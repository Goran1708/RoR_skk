FactoryBot.define do
  factory :user do
    factory :user_operator do
      email "email12@email.com "
      password "password"
      password_confirmation "password"
      first_name "First"
      last_name "Last"
      operator { Operator.first || association(:operator) }
    end
    factory :customer do
      email "email13@email.com "
      password "password"
      password_confirmation "password"
      first_name "First"
      last_name "Last"
    end
  end
  factory :card_type do
    type_name "Name"
  end
  factory :card do
    card_number "1234567812345678"
    cvv "123"
    expiration_date "2019-04-26 11:50:32"
    card_type
    user { User.first || association(:customer) }
  end
  factory :card_account do
    balance 1000
    card
  end
  factory :purchase_history do
    user { User.first || association(:customer) }
  end
  factory :operator do
    name "Name"
  end
  factory :order_item do
    total 100
    amount 1
    ticket { Ticket.first || association(:ticket) }
    purchase_history { PurchaseHistory.first || association(:purchase_history) }
  end
  factory :ticket do
    destination "Zagreb"
    quantity 10
    price 100
    operator
    departure Time.now + 2.hours
    arrival Time.now + 5.hours
  end
end
