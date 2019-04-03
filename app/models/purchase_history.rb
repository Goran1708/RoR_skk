class PurchaseHistory < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :tickets, through: :order_items

  def purchase_ticket(ticket)
    order_item = order_items.find_by(ticket_id: ticket.id)

    if order_item
      order_item.increment(:amount)
    else
      order_items.build(ticket_id: ticket.id)
    end
  end
end
