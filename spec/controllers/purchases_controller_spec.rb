require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  describe "POST purchases#buy_ticket" do
    it "should purchase ticket and route to purchase histories" do
      operator = create(:operator)
      ticket = create(:ticket)
      user_operator = create(:user_operator)
      sign_in(user_operator)

      post :buy_ticket, params: { card_number: "1234567812345678", cvv: "567", ticket_id: ticket.id }

      expect(response.content_type).to eq "text/html"
      expect(response).to redirect_to("/purchase")
      expect(flash[:notice]).to match(/^You bought the ticket!/)
    end

    it "should not purchase ticket and route to root path and show card data invalid" do
      operator = create(:operator)
      ticket = create(:ticket)
      user_operator = create(:user_operator)
      sign_in(user_operator)

      post :buy_ticket, params: { card_number: "1234567812345677", cvv: "567", ticket_id: ticket.id }

      expect(response.content_type).to eq "text/html"
      expect(response).to redirect_to(:root)
      expect(flash[:alert]).to match("Credit card data invalid")
    end

    it "should not purchase ticket and route to root path and show card data invalid" do
      operator = create(:operator)
      ticket = create(:ticket, quantity: 0)
      user_operator = create(:user_operator)
      sign_in(user_operator)

      post :buy_ticket, params: { card_number: "1234567812345678", cvv: "567", ticket_id: ticket.id }

      expect(response.content_type).to eq "text/html"
      expect(response).to redirect_to(:root)
      expect(flash[:alert]).to match("Out of tickets.")
    end

    it "should not purchase ticket and route to root path and show user does not have enough funds" do
      operator = create(:operator)
      ticket = create(:ticket, price: 10000)
      user_operator = create(:user_operator)
      sign_in(user_operator)

      post :buy_ticket, params: { card_number: "1234567812345678", cvv: "567", ticket_id: ticket.id }

      expect(response.content_type).to eq "text/html"
      expect(response).to redirect_to(:root)
      expect(flash[:alert]).to match("User does not have enough funds.")
    end
  end

  describe "DELETE purchases#cancel_ticket" do
    it "should cancel ticket" do
      ticket = create(:ticket)
      order_item = create(:order_item)
      user = User.first
      sign_in(user)

      delete :cancel_ticket, params: { order_item_id: order_item.id }

      expect(response.content_type).to eq "text/html"
      expect(response).to redirect_to(:root)
      expect(flash[:notice]).to match('Ticket was successfuly canceled.')

      ticket.reload.quantity.should eq(11)
    end

    it "fail to cancel ticket" do
      order_item = create(:order_item)

      delete :cancel_ticket, params: { order_item_id: order_item.id }

      expect(response.content_type).to eq "text/html"
      expect(response).to redirect_to("/users/sign_in")
      expect(flash[:alert]).to match("You need to sign in or sign up before continuing.")
    end

    it "fail to cancel ticket 1 hour before departure" do
      order_item = create(:order_item)
      ticket = order_item.ticket
      ticket.departure = Time.now + 1.hours
      ticket.save
      user = User.first
      sign_in(user)

      delete :cancel_ticket, params: { order_item_id: order_item.id }

      expect(response.content_type).to eq "text/html"
      expect(response).to redirect_to(purchase_history_path)
      expect(flash[:alert]).to match("Cannot delete order 1 hour before departure")
    end
  end
end
