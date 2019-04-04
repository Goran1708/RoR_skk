module PaymentServices
  class PurchaseTicket

    def self.call(params, purchase_history, user)
      @user = user
      @ticket = Ticket.find(params[:ticket_id])

      card = fetch_card_data(params[:card_number], params[:cvv])
      ticket_quantity_valid(@ticket)
      user_has_enough_funds(@ticket, card)

      ActiveRecord::Base.transaction do
        decrement_ticket_quantity!(@ticket)
        decrement_user_funds!(purchase_history, @ticket)
        purchase_ticket(@ticket, purchase_history)
      end
    end

    def self.purchase_ticket(ticket, purchase_history)
      order_item = purchase_history.order_items.find_by(ticket_id: ticket.id)

      if order_item
        order_item.increment(:amount)
      else
        purchase_history.order_items.build(ticket_id: ticket.id)
      end
    end

    def self.decrement_ticket_quantity!(ticket)
      ticket.decrement(:quantity, 1)
      ticket.save!
    end

    def self.decrement_user_funds!(purchase_history, ticket)
      card_account = @user.get_card_account
      card_account.decrement(:balance, ticket.price)
      card_account.save!
    end

    def self.fetch_card_data(card_number, cvv)
      card = Card.find_by_card_number(card_number, cvv, @user.id).first
      if !card
        raise Error::CustomError.new(422, :unprocessable_entity, "Credit card data invalid")
      end
      card
    end

    def self.ticket_quantity_valid(ticket)
      if (ticket.quantity <= 0)
        raise Error::CustomError.new(422, :unprocessable_entity, "Out of tickets.")
      end
    end

    def self.user_has_enough_funds(ticket, card)
      if (ticket.price > card.card_accounts.first.balance)
        raise Error::CustomError.new(422, :unprocessable_entity, "User does not have enough funds.")
      end
    end
  end
end
