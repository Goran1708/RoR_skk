module PaymentServices
  class Payment

    def self.call(params, purchase_history)
      @ticket = Ticket.find(params[:ticket_id])
      card = credit_card_valid(params[:card_number], params[:cvv])
      ticket_quantity_valid(@ticket)
      user_has_enough_funds(@ticket, card)

      purchase_history.purchase_ticket(@ticket)
    end

    def self.credit_card_valid(card_number, cvv)
      card = Card.find_by_card_number(card_number, cvv).first
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
