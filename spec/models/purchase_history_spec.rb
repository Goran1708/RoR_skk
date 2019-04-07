require 'rails_helper'

RSpec.describe PurchaseHistory, type: :model do

  it "is valid" do
    user = create(:customer)
    purchase_history = PurchaseHistory.new(user_id: user.id)
    expect(purchase_history).to be_valid
  end

  it "user should be present" do

    purchase_history = PurchaseHistory.new()
    expect(purchase_history).to_not be_valid
  end
end
