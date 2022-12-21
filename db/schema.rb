# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_12_21_183151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "connection_id"
    t.string "api_id"
    t.string "name"
    t.integer "nature"
    t.decimal "balance", precision: 12, scale: 3
    t.string "currency_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["connection_id"], name: "index_accounts_on_connection_id"
  end

  create_table "connections", force: :cascade do |t|
    t.string "uuid"
    t.bigint "customer_id"
    t.string "connection_id", null: false
    t.string "connection_secret"
    t.datetime "expires_at"
    t.string "attempt_id"
    t.string "token"
    t.string "access_token"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "next_refresh"
    t.index ["connection_id"], name: "index_connections_on_connection_id"
    t.index ["customer_id"], name: "index_connections_on_customer_id"
    t.index ["uuid"], name: "index_connections_on_uuid"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "api_id"
    t.string "api_secret"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "account_id"
    t.string "api_id"
    t.boolean "duplicated"
    t.integer "mode"
    t.integer "status"
    t.date "made_on"
    t.decimal "amount", precision: 12, scale: 3
    t.string "currency_code"
    t.string "description"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["firstname"], name: "index_users_on_firstname"
    t.index ["lastname"], name: "index_users_on_lastname"
  end

end
