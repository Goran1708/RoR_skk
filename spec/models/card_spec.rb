require 'rails_helper'

RSpec.describe Card, type: :model do
  before(:all) do
    @user = create(:customer)
  end

  it "is valid" do
    card_type = create(:card_type)
    card = Card.new(user_id: @user.id, card_type_id: card_type.id, card_number_undigest: "1234567812345678", cvv_undigest: "123", expiration_date: Time.now + 5.years)

    expect(card).to be_valid
  end

  it "card type is present" do
    card = Card.new(user_id: @user.id, card_number_undigest: "1234567812345678", cvv_undigest: "123", expiration_date: Time.now + 5.years)

    expect(card).to_not be_valid
  end

  it "user is present" do
    card_type = create(:card_type)
    card = Card.new(card_type_id: card_type.id, card_number_undigest: "1234567812345678", cvv_undigest: "123", expiration_date: Time.now + 5.years)

    expect(card).to_not be_valid
  end

  it "expiration date is present" do
    card_type = create(:card_type)
    card = Card.new(user_id: @user.id, card_type_id: card_type.id, card_number_undigest: "1234567812345678", cvv_undigest: "123")

    expect(card).to_not be_valid
  end

  it "cvv is present" do
    card_type = create(:card_type)
    card = Card.new(user_id: @user.id, card_type_id: card_type.id, card_number_undigest: "1234567812345678", expiration_date: Time.now + 5.years)

    expect(card).to_not be_valid
  end

  it "card number is present" do
    card_type = create(:card_type)
    card = Card.new(user_id: @user.id, card_type_id: card_type.id, cvv_undigest: "123", expiration_date: Time.now + 5.years)

    expect(card).to_not be_valid
  end

  it "is valid and card number and ccv are digested" do
    card_type = create(:card_type)
    card = Card.new(user_id: @user.id, card_type_id: card_type.id, card_number_undigest: "1234567812345678", cvv_undigest: "123", expiration_date: Time.now + 5.years)
    card.save!

    card.reload.card_number.should_not eq("1234567812345678")
    card.reload.cvv.should_not eq("123")
    card.reload.card_number.should_not eq(nil)
    card.reload.cvv.should_not eq(nil)

    expect(card).to be_valid
  end

  it "is valid and card number and ccv are digested" do
    card = Card.find_by_card_number("1234567812345678", "567", @user.id).first

    #card.reload.expiration_date.should eq("2019-04-26 11:50:32")
    card.reload.card_number.should_not eq("1234567812345678")
    card.reload.cvv.should_not eq("123")
    card.reload.card_number.should_not eq(nil)
    card.reload.should_not eq(nil)
  end
end
