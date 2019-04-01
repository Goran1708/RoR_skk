class Ticket < ApplicationRecord
  belongs_to :operator
  has_many :order_items
  has_many :purchase_histories, through: :order_items
end
