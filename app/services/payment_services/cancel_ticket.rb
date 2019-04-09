module PaymentServices
  class CancelTicket

    def self.call(params, user)
      @user = user
      @order_item = OrderItem.find(params[:order_item_id])

      is_eligible_for_delete?

      ActiveRecord::Base.transaction do
        set_ticket_quantity_to_before!
        increment_user_funds!
        @order_item.destroy
      end

      @order_item
    end

    def self.set_ticket_quantity_to_before!
      ticket = @order_item.ticket
      ticket.increment(:quantity, @order_item.amount)
      ticket.save!
    end

    def self.increment_user_funds!
      card_account = @user.get_card_account
      card_account.increment(:balance, @order_item.ticket.price)
      card_account.save!
    end

    def self.is_eligible_for_delete?
      if (@order_item.ticket.departure < (Time.now.utc + 1.hours))
        raise Error::CustomError.new(422, :unprocessable_entity, "Cannot delete order 1 hour before departure")
      end
    end
  end
end
