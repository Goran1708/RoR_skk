class Operator < ApplicationRecord
  has_many :tickets
  has_many :users
end
