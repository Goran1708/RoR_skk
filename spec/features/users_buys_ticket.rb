require 'rails_helper'

feature 'User buys a ticket' do
  scenario 'they buy a ticket and go to purchase history' do
    visit new_user_session_path
    ticket = create(:ticket)
    customer = create(:customer)

    fill_in 'user_email', with: 'email13@email.com'

    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    page.should have_content(ticket.destination)
    page.should have_content(ticket.operator.name)
    page.should have_content(ticket.departure)
    page.should have_content(ticket.arrival)
    page.should have_content("Amount")
    page.should have_content(10)
    page.should have_content("Price")
    page.should have_content(100)
    click_link 'Buy'

    page.should have_content(ticket.destination)
    page.should have_content(ticket.operator.name)
    page.should have_content(ticket.departure)
    page.should have_content(ticket.arrival)
    page.should have_content(customer.email)
    page.should have_content(customer.full_name)

    fill_in 'card_number', with: '1234567812345678'
    fill_in 'cvv', with: '567'

    click_button 'Buy Ticket'

    page.should have_content("Purchase history")
    page.should have_content("You bought the ticket!")

    page.should have_content(ticket.destination)
    page.should have_content(ticket.operator.name)
    page.should have_content(ticket.departure)
    page.should have_content(ticket.arrival)

    page.should have_content("Cancel")
  end

  scenario 'they input wrong card credentials' do
    visit new_user_session_path
    ticket = create(:ticket)
    customer = create(:customer)

    fill_in 'user_email', with: 'email13@email.com'

    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    page.should have_content(ticket.destination)
    page.should have_content(ticket.operator.name)
    page.should have_content(ticket.departure)
    page.should have_content(ticket.arrival)
    page.should have_content("Amount")
    page.should have_content(10)
    page.should have_content("Price")
    page.should have_content(100)

    click_link 'Buy'

    page.should have_content(ticket.destination)
    page.should have_content(ticket.operator.name)
    page.should have_content(ticket.departure)
    page.should have_content(ticket.arrival)
    page.should have_content(customer.email)
    page.should have_content(customer.full_name)

    fill_in 'card_number', with: '1234567812345678'
    fill_in 'cvv', with: '568'

    click_button 'Buy Ticket'

    page.should have_content("Credit card data invalid")
    page.should have_content("Tickets")

  end
end
