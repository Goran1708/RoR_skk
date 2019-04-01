class OrderItem < ApplicationRecord
  belongs_to :purchase_history
  belongs_to :ticket
end
