module PaymentServices
  class Payment

    def self.call(params, purchase_history)
      @ticket = Ticket.find(params[:ticket_id])
      credit_card_valid(params[:card_number], params[:cvv])
      ticket_quantity_valid(@ticket)

      purchase_history.purchase_ticket(@ticket)
    end

    def self.credit_card_valid(card_number, cvv)
      card = Card.find_by_card_number(card_number, cvv).first
      if !card
        raise Error::CustomError.new(422, :unprocessable_entity, "Credit card data invalid")
      end
    end

    def self.ticket_quantity_valid(ticket)
      if (ticket.quantity <= 0)
        raise Error::CustomError.new(422, :unprocessable_entity, "Out of tickets.")
      end
    end
  end
end
