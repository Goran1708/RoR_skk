require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "validate new OrderItem" do
    it "is valid" do
      ticket = create(:ticket)
      purchase_history = create(:purchase_history)
      order_item = OrderItem.create!(ticket_id: ticket.id, purchase_history_id: purchase_history.id)

      order_item.total.should eq(100)
      expect(order_item).to be_valid
    end

    it "ticket should be presents" do
      purchase_history = create(:purchase_history)
      order_item = OrderItem.new(purchase_history_id: purchase_history.id)

      expect(order_item).to_not be_valid
    end

    it "purchase_history should be presents" do
      ticket = create(:ticket)
      order_item = OrderItem.new(ticket_id: ticket.id)

      expect(order_item).to_not be_valid
    end

    it "purchase_history should be presents" do
      ticket = create(:ticket)
      order_item = OrderItem.new(ticket_id: ticket.id)

      expect(order_item).to_not be_valid
    end
  end

  describe "destroy order item" do
    it "should destroy" do
      ticket_no_amount = create(:ticket, quantity: 1)
      purchase_history = create(:purchase_history)

      ticket_no_amount.reload.quantity.should eq(1)
      purchase_history.user.get_card_account.balance.should eq(1000)

      order_item = OrderItem.create!(ticket_id: ticket_no_amount.id, purchase_history_id: purchase_history.id)
      order_item.destroy

      ticket_no_amount.reload.quantity.should eq(2)
      purchase_history.user.get_card_account.balance.should eq(1100)
      expect(order_item).to be_valid
    end

    it "is not eligible for delete departure to early" do
      ticket = create(:ticket, quantity: 1, departure: Time.now)
      purchase_history = create(:purchase_history)
      order_item = OrderItem.create!(ticket_id: ticket.id, purchase_history_id: purchase_history.id)
      order_item.destroy

      ticket.reload.quantity.should eq(1)
      purchase_history.user.get_card_account.balance.should eq(1000)
      expect(order_item.errors[:base].size).to eq(1)

      #no idea why order_item is still valid
      #expect(order_item.reload).to be_valid
    end
  end
end
