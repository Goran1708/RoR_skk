require 'rails_helper'

RSpec.describe PaymentServices::CancelTicket do
  it 'should cancel ticket' do
    customer = User.first || create(:customer)
    order_item = create(:order_item)
    params = { order_item_id: order_item.id}

    order_item.ticket.quantity.should eq(10)
    order_item.purchase_history.user.get_card_account.balance.should eq(1000)

    order_item = PaymentServices::CancelTicket.call(params, customer)

    order_item.ticket.quantity.should eq(11)
    order_item.purchase_history.user.get_card_account.balance.should eq(1100)
  end

  it 'throws error not eligible for delete' do
    ticket = create(:ticket, departure: Time.now)
    user_operator = create(:user_operator)
    order_item = create(:order_item)
    params = { order_item_id: order_item.id}

    order_item.ticket.quantity.should eq(10)
    order_item.purchase_history.user.get_card_account.balance.should eq(1000)

    expect{ PaymentServices::CancelTicket.call(params, user_operator) }.to raise_error(Error::CustomError, "Cannot delete order 1 hour before departure")

    order_item.ticket.quantity.should eq(10)
    order_item.purchase_history.user.get_card_account.balance.should eq(1000)
  end
end
