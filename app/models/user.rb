class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :purchase_history

  after_create_commit :set_purchase_history!

  def set_purchase_history!
    @purchase_history = PurchaseHistory.create(user_id: self.id)
  end

  def full_name
    self.first_name + " " + self.last_name
  end
end
