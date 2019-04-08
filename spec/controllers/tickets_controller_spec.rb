require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  #render_views

  describe "GET tickets#index" do
    context "when the user is an operator" do
      it "should list all tickets" do
        user_operator = create(:user_operator)
        ticket = create(:ticket)

        sign_in(user_operator)
        get :index

        expect(response).to render_template("index")
        expect(assigns(:tickets)).to eq([ticket])
      end
    end

    # context "when the user is not an operator" do
    # end
  end

  describe "POST tickets#create" do
    it "should create ticket and route to root path" do
      operator = create(:operator)
      ticket = create(:ticket)
      post :create, params: { ticket: { destination: "Bla", price: 100, quantity: 10, departure: "2019-04-07 21:00:00", arrival: "2019-04-07 23:00:00", operator_id: operator.id}}
      #post tickets_patch(@ticket)

      expect(response.content_type).to eq "text/html"
      expect(response).to redirect_to(:root)
      expect(flash[:notice]).to match(/^Ticket was successfully created./)
    end
  end
end
