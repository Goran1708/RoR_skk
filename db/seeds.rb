# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first


operator =
  Operator.create!([
    { name: "Cazmatrans" },
    { name: "Autotrans" },
    { name: "Croatia Bus" }
    ])

user = User.create!(email: "admin@admin.com",
  first_name: "first",
  last_name: "last",
  password: "password",
  password_confirmation: "password",
  operator: operator[0])

user2 = User.create!(email: "admin@autotrans.com",
  first_name: "auto",
  last_name: "trans",
  password: "password",
  password_confirmation: "password",
  operator: operator[1])

user3 = User.create!(email: "admin@user.com",
  first_name: "croatia",
  last_name: "bus",
  password: "password",
  password_confirmation: "password")

Ticket.create!([
  { destination: "Split",
  quantity: 10,
  price: 100,
  operator_id: operator.first.id,
  departure: "2019-04-26 11:50:32",
  arrival: "2019-04-26 15:50:32" },
  {destination: "Dubrovnik",
  departure: "2019-04-24 11:50:32",
  quantity: 5,
  price: 200,
  operator_id: operator.second.id,
  arrival: "2019-04-24 16:50:32"},
  {destination: "Zadar",
  quantity: 7,
  price: 50,
  operator_id: operator.second.id,
  departure: "2019-05-15 11:50:32",
  arrival: "2019-05-15 13:50:32"},
  {destination: "Sibenik",
  quantity: 2,
  price: 70,
  operator_id: operator.third.id,
  departure: "2019-04-01 11:50:32",
  arrival: "2019-04-01 14:50:32"},
  {destination: "Rijeka",
  quantity: 3,
  price: 50,
  operator_id: operator.third.id,
  departure: Time.now + 1.hours,
  arrival: Time.now + 1.hours}
  ])

# card_type = CardType.create!(type_name: "MASTERCARD")
#
# card = Card.create!(card_number: "1234567812345678", ccv: "567", expiration_date: "2021-04-24 16:50:32", card_type_id: card_type.id, user_id: user.id)
#
# CardAccount.create!(balance: 1000, card_id: card.id)
