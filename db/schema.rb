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

ActiveRecord::Schema.define(version: 2019_06_18_152838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "charges", force: :cascade do |t|
    t.string "uid", limit: 50
    t.integer "status", default: 0
    t.integer "payment_method", default: 0
    t.decimal "amount", default: "0.0"
    t.text "error_message"
    t.jsonb "response_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.index ["order_id"], name: "index_charges_on_order_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "telephone"
    t.string "email"
    t.integer "radius"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_locations_on_addressable_type_and_addressable_id"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.integer "status"
    t.datetime "status_time"
    t.text "status_details"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_statuses_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.text "description"
    t.decimal "weight"
    t.decimal "length"
    t.decimal "width"
    t.decimal "heigth"
    t.datetime "pickup_time"
    t.datetime "delivery_time"
    t.decimal "cost"
    t.integer "status"
    t.integer "radius"
    t.bigint "sender_id"
    t.bigint "transporter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sender_id"], name: "index_orders_on_sender_id"
    t.index ["transporter_id"], name: "index_orders_on_transporter_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.string "name"
    t.string "telephone"
    t.string "email"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_recipients_on_order_id"
  end

  create_table "senders", force: :cascade do |t|
    t.string "name"
    t.string "telephone"
    t.string "email"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_senders_on_email", unique: true
    t.index ["reset_password_token"], name: "index_senders_on_reset_password_token", unique: true
  end

  create_table "transporters", force: :cascade do |t|
    t.string "name"
    t.string "telephone"
    t.string "email"
    t.integer "status"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["company_id"], name: "index_transporters_on_company_id"
    t.index ["email"], name: "index_transporters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_transporters_on_reset_password_token", unique: true
  end

  add_foreign_key "charges", "orders"
  add_foreign_key "order_statuses", "orders"
  add_foreign_key "orders", "senders"
  add_foreign_key "orders", "transporters"
  add_foreign_key "recipients", "orders"
  add_foreign_key "transporters", "companies"
end
