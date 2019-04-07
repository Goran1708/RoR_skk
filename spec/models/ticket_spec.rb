require 'rails_helper'

RSpec.describe Ticket, type: :model do

  before(:all) do
    @operator = create(:operator)
  end

  it "operator should be present" do
    ticket = Ticket.new(destination: "Destination", departure: Time.now, arrival: Time.now + 1.hour, quantity: 4, price: 100)
    expect(ticket).to_not be_valid
  end

  it "destination should be present" do
    ticket = Ticket.new(departure: Time.now, arrival: Time.now + 1.hour, quantity: 4, price: 100, operator_id:  @operator.id)
    expect(ticket).to_not be_valid
  end

  it "departure should be present" do
    ticket = Ticket.new(destination: "Destination", arrival: Time.now + 1.hour, quantity: 4, price: 100, operator_id:  @operator.id)
    expect(ticket).to_not be_valid
  end

  it "arrival should be present" do
    ticket = Ticket.new(destination: "Destination", departure: Time.now, quantity: 4, price: 100, operator_id:  @operator.id)
    expect(ticket).to_not be_valid
  end

  it "quantity should be present" do
    ticket = Ticket.new(destination: "Destination", departure: Time.now, arrival: Time.now + 1.hour, price: 100, operator_id:  @operator.id)
    expect(ticket).to_not be_valid
  end

  it "price should be present" do
    ticket = Ticket.new(destination: "Destination", departure: Time.now, arrival: Time.now + 1.hour, quantity: 4, operator_id:  @operator.id)
    expect(ticket).to_not be_valid
  end

  it "price should be greater then 0" do
    ticket = Ticket.new(destination: "Destination", departure: Time.now, arrival: Time.now + 1.hour, quantity: 4, price: -100, operator_id:  @operator.id)
    expect(ticket).to_not be_valid
  end

  it "quantity should be greater then or equal to 0" do
    ticket = Ticket.new(destination: "Destination", departure: Time.now, arrival: Time.now + 1.hour, quantity: -1, price: 100, operator_id:  @operator.id)
    expect(ticket).to_not be_valid
  end

  it "is valid" do
    ticket = Ticket.new(destination: "Destination", departure: Time.now, arrival: Time.now + 1.hour, quantity: 4, price: 100, operator_id:  @operator.id)
    expect(ticket).to be_valid
  end
end
