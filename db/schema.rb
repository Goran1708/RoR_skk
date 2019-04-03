# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_03_195016) do

  create_table "card_accounts", force: :cascade do |t|
    t.integer "card_id"
    t.integer "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_accounts_on_card_id"
  end

  create_table "card_types", force: :cascade do |t|
    t.string "type_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string "card_number_digest"
    t.string "cvv_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "expiration_date"
    t.integer "user_id"
    t.integer "card_type_id"
    t.index ["card_type_id"], name: "index_cards_on_card_type_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "operators", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "purchase_history_id"
    t.integer "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount", default: 1
    t.integer "total"
    t.index ["purchase_history_id"], name: "index_order_items_on_purchase_history_id"
    t.index ["ticket_id"], name: "index_order_items_on_ticket_id"
  end

  create_table "purchase_histories", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_purchase_histories_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "destination"
    t.datetime "departure"
    t.datetime "arrival"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "operator_id"
    t.integer "quantity"
    t.decimal "price"
    t.index ["operator_id"], name: "index_tickets_on_operator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
