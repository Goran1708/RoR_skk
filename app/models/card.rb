class Card < ApplicationRecord
  attr_accessor :card_number_undigest, :cvv_undigest
  belongs_to :user
  has_many :card_accounts
  belongs_to :card_type

  validates :card_type, :length => { :minimum => 1 }
  validates :card_number, presence: true
  validates :cvv, presence: true
  validates :expiration_date, presence: true

  after_initialize :digest_card_data

  def self.find_by_card_number(card_number, cvv, user_id)
    set_digest
    card_number_digest = @sha256.base64digest(card_number)
    cvv_digest = @sha256.base64digest(cvv)

    puts "card_number_digest: " + card_number_digest
    puts "cvv_digest: " + cvv_digest
    puts "user_id: " + user_id.to_s
    where(:card_number => card_number_digest).
    where(:cvv => cvv_digest).
    where(:user_id => user_id)
  end

  def digest_card_data
    @sha256 = self.class.set_digest

    self.card_number = @sha256.base64digest(@card_number_undigest) if @card_number_undigest.present?
    self.cvv = @sha256.base64digest(@cvv_undigest) if @cvv_undigest.present?

    @cvv_undigest = nil
    @card_number_undigest = nil
  end

  private

    def self.set_digest
      @sha256 = Digest::SHA256.new
    end
end
