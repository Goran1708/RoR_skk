class OrderItem < ApplicationRecord
  belongs_to :purchase_history
  belongs_to :ticket

  before_save :set_total!

  before_destroy :is_eligible_for_delete?
  after_destroy :set_product_quantity_to_before!, :increment_user_funds!

  def set_total!
    self.total = ticket.price * self.amount
  end

  def set_product_quantity_to_before!
    ticket.increment(:quantity, self.amount)
    ticket.save
  end

  def increment_user_funds!
    card_account = purchase_history.user&.cards&.first&.card_accounts&.first
    card_account.increment(:balance, ticket.price)
    card_account.save
  end

  def is_eligible_for_delete?
    return true if ticket.departure > (Time.now + 1.hours)

    errors.add :base, "Cannot delete order 1 hour before departure"
    false
  end
end
