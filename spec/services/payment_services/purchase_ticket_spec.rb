require 'rails_helper'

RSpec.describe PaymentServices::PurchaseTicket do
  it 'returns order item' do
    user = create(:user_operator)
    ticket = create(:ticket)
    purchase_history = create(:purchase_history)
    params = { cvv: "567", card_number: "1234567812345678", ticket_id: ticket.id}

    order_item = PaymentServices::PurchaseTicket.call(params, purchase_history, user)

    order_item.amount.should eq(1)
    order_item.purchase_history_id.should eq(purchase_history.id)
    order_item.ticket_id.should eq(ticket.id)
  end

  it 'throws error card data invalid' do
    user = create(:user_operator)
    ticket = create(:ticket)
    purchase_history = create(:purchase_history)
    params = { cvv: "567", card_number: "1234567812345677", ticket_id: ticket.id}

    expect{ PaymentServices::PurchaseTicket.call(params, purchase_history, user)}.to raise_error(Error::CustomError, "Credit card data invalid")
  end

  it 'throws error card data invalid' do
    user = create(:user_operator)
    ticket = create(:ticket, quantity: 0)
    purchase_history = create(:purchase_history)
    params = { cvv: "567", card_number: "1234567812345678", ticket_id: ticket.id}

    expect{ PaymentServices::PurchaseTicket.call(params, purchase_history, user)}.to raise_error(Error::CustomError, "Out of tickets.")
  end

  it 'throws error card data invalid' do
    user = create(:user_operator)
    ticket = create(:ticket, price: 10000)
    purchase_history = create(:purchase_history)
    params = { cvv: "567", card_number: "1234567812345678", ticket_id: ticket.id}

    expect{ PaymentServices::PurchaseTicket.call(params, purchase_history, user)}.to raise_error(Error::CustomError, "User does not have enough funds.")
  end
end
