require 'rails_helper'

RSpec.describe CardAccount, type: :model do
  it "is valid" do
    card = create(:card)
    card_account = CardAccount.new(card_id: card.id, balance: 1000)

    expect(card_account).to be_valid
  end

  it "is valid no balance" do
    card = create(:card)
    card_account = CardAccount.new(card_id: card.id, balance: 0)

    expect(card_account).to be_valid
  end

  it "balance must be greater then 0" do
    card = create(:card)
    card_account = CardAccount.new(card_id: card.id, balance: -100)

    expect(card_account).to_not be_valid
  end
end
