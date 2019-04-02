class OrderItem < ApplicationRecord
  belongs_to :purchase_history
  belongs_to :ticket

  before_save :set_total!
  after_save :decrement_ticket_quantity!

  after_destroy :set_product_quantity_to_before!

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
end
