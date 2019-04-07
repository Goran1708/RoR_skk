class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name

  has_one :purchase_history
  has_many :cards
  belongs_to :operator, optional: true

  after_create_commit :set_purchase_history!, :set_card_details!

  def is_operator?
    self.operator.present?
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def get_card_account
    cards.first&.card_accounts&.first
  end

  #hardcoded
  def set_card_details!
    card_type = CardType.find_or_create_by!(type_name: "MASTERCARD")

    card = Card.create!(card_number_undigest: "1234567812345678", cvv_undigest: "567", expiration_date: Time.now + 5.years, card_type_id: card_type.id, user_id: self.id)

    CardAccount.create!(balance: 1000, card_id: card.id)
  end

  def set_purchase_history!
    @purchase_history = PurchaseHistory.create(user_id: self.id)
  end
end
