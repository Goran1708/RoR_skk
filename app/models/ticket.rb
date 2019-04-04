class Ticket < ApplicationRecord
  belongs_to :operator
  has_many :order_items
  has_many :purchase_histories, through: :order_items

  validates_numericality_of :quantity, :greater_than_or_equal_to => 0
end
