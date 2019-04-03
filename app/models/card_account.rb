class CardAccount < ApplicationRecord
  belongs_to :card

  validates_numericality_of :balance, :allow_nil => true, :greater_than_or_equal_to => 0
end
