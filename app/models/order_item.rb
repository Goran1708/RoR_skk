class OrderItem < ApplicationRecord
  belongs_to :purchase_history
  belongs_to :ticket

  before_save :set_total!
  after_save :decrement_ticket_quantity!

  after_destroy :set_product_quantity_to_before!

  before_destroy :is_eligible_for_delete?

  def decrement_ticket_quantity!
    ticket.decrement(:quantity, 1)
    ticket.save
  end

  def set_total!
    self.total = ticket.price * self.amount
  end

  def set_product_quantity_to_before!
    ticket.increment(:quantity, self.amount)
    ticket.save
  end

  def is_eligible_for_delete?
    return true if ticket.departure > (Time.now + 1.hours)

    errors.add :base, "Cannot delete order 1 hour before departure"
    false
  end
end
