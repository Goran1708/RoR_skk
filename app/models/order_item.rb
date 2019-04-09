class OrderItem < ApplicationRecord
  belongs_to :purchase_history
  belongs_to :ticket

  before_save :set_total!

  default_scope { includes(ticket: :operator).order('tickets.departure') }

  def set_total!
    self.total = ticket.price * self.amount
  end
end
