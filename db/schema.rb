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

ActiveRecord::Schema.define(version: 20170930165829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "debts", force: :cascade do |t|
    t.string "filer_id"
    t.integer "election_year"
    t.integer "election_cycle"
    t.string "debt_reporter_name"
    t.string "debt_reporting_address_1"
    t.string "debt_reporting_address_2"
    t.string "debt_reporting_city"
    t.string "debt_reporting_state"
    t.string "debt_reporting_zipcode"
    t.date "debt_accrual_date"
    t.float "debt_amount"
    t.string "debt_description"
    t.string "debt_reporting_location_1"
    t.string "debt_reporting_location2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "filer_id"
    t.integer "election_year"
    t.integer "election_cycle"
    t.string "name"
    t.string "expense_address_1"
    t.string "expense_address_2"
    t.string "expense_city"
    t.string "expense_state"
    t.string "expense_zipcode"
    t.date "expense_date"
    t.float "expense_amount"
    t.string "expense_description"
    t.string "expense_location_1"
    t.string "expense_location_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.integer "filer_id"
    t.integer "election_year"
    t.integer "election_cycle"
    t.string "name"
    t.string "receipt_address_1"
    t.string "receipt_address_2"
    t.string "receipt_city"
    t.string "receipt_state"
    t.string "receipt_zipcode"
    t.string "receipt_description"
    t.date "receipt_date"
    t.float "receipt_amount"
    t.string "receipt_location_1"
    t.string "receipt_location_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
