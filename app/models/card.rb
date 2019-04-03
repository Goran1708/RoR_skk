class Card < ApplicationRecord
  attr_accessor :card_number, :ccv
  belongs_to :user
  has_many :card_accounts
  belongs_to :card_type

  validates :card_type, :length => { :minimum => 1 }

  before_save :digest_card_data

  def self.find_by_card_number(card_number, cvv)
    set_digest
    card_number_digest = @sha256.base64digest(card_number)
    cvv_digest = @sha256.base64digest(cvv)

    where(:card_number_digest => card_number_digest).
    where(:cvv_digest => cvv_digest)
  end

  def digest_card_data
    @sha256 = self.class.set_digest
    self.card_number_digest = @sha256.base64digest(@card_number)
    self.cvv_digest = @sha256.base64digest(@ccv)
  end

  private

    def self.set_digest
      @sha256 = Digest::SHA256.new
    end
end
