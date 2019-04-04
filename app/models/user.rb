class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :purchase_history
  has_many :cards
  has_one :operator

  after_create_commit :set_purchase_history!, :set_card_details!

  def set_purchase_history!
    @purchase_history = PurchaseHistory.create(user_id: self.id)
  end

  def is_operator?
    self.operator.present?
  end

  def get_card_account
    cards.first&.card_accounts&.first
  end

  def set_card_details!
    card_type = CardType.find_or_create_by!(type_name: "MASTERCARD")

    card = Card.create!(card_number: "1234567812345678", ccv: "567", expiration_date: "2021-04-24 16:50:32", card_type_id: card_type.id, user_id: self.id)

    CardAccount.create!(balance: 1000, card_id: card.id)
  end

  def full_name
    self.first_name + " " + self.last_name
  end
end
