class OrderItem < ApplicationRecord
  belongs_to :purchase_history
  belongs_to :ticket

  before_save :set_total!, :decrement_user_funds!
  after_save :decrement_ticket_quantity!

  after_destroy :set_product_quantity_to_before!, :increment_user_funds!

  before_destroy :is_eligible_for_delete?

  def decrement_ticket_quantity!
    puts "decrement_ticket_quantity: "
    ticket.decrement(:quantity, 1)
    ticket.save
  end

  def decrement_user_funds!
    card_account = purchase_history.user.cards.first.card_accounts.first
    card_account.decrement(:balance, ticket.price)
    card_account.save
    # value = !card_account.save
    # if value
    #   errors.add :base, card_account.errors.full_messages
    #   throw :abort
    # end
  end

  def set_total!
    self.total = ticket.price * self.amount
  end

  def set_product_quantity_to_before!
    ticket.increment(:quantity, self.amount)
    ticket.save
  end

  def increment_user_funds!
    card_account = purchase_history.user.cards.first.card_accounts.first
    card_account.increment(:balance, ticket.price)
    card_account.save
  end

  def is_eligible_for_delete?
    return true if ticket.departure > (Time.now + 1.hours)

    errors.add :base, "Cannot delete order 1 hour before departure"
    false
  end
end
