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
end
