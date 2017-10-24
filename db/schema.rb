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

ActiveRecord::Schema.define(version: 20171024015918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "congressional_districts", force: :cascade do |t|
    t.string "c_first_name"
    t.string "c_last_name"
    t.string "home_county"
    t.string "party"
    t.integer "legislative_district"
    t.json "feature"
  end

  create_table "contributions", force: :cascade do |t|
    t.integer "filer_id"
    t.integer "election_year"
    t.integer "election_cycle"
    t.string "section"
    t.string "contributor"
    t.string "contributor_address_1"
    t.string "contributor_address_2"
    t.string "contributor_city"
    t.string "contributor_state"
    t.string "contributor_zipcode"
    t.string "occupation"
    t.string "employer_name"
    t.string "employer_address_1"
    t.string "employer_address_2"
    t.string "employer_state"
    t.string "employer_city"
    t.string "employer_zipcode"
    t.date "contribution_date"
    t.float "contribution_amount"
    t.string "contribution_description"
    t.json "contributor_location_1"
    t.json "contributor_location_2"
    t.json "employer_location_1"
    t.json "employer_location_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "contributor_location_1_lat"
    t.float "contributor_location_1_long"
    t.float "contributor_location_2_lat"
    t.float "contributor_location_2_long"
    t.string "contributor_location_1_address"
    t.string "contributor_location_2_address"
    t.string "contributor_location_1_city"
    t.string "contributor_location_2_city"
    t.string "contributor_location_1_state"
    t.string "contributor_location_2_state"
    t.string "contributor_location_1_zip"
    t.string "contributor_location_2_zip"
    t.float "employer_location_1_lat"
    t.float "employer_location_1_long"
    t.float "employer_location_2_lat"
    t.float "employer_location_2_long"
    t.string "employer_location_1_address"
    t.string "employer_location_2_address"
    t.string "employer_location_1_city"
    t.string "employer_location_2_city"
    t.string "employer_location_1_state"
    t.string "employer_location_2_state"
    t.string "employer_location_1_zip"
    t.string "employer_location_2_zip"
    t.integer "state_fips"
    t.integer "county_fips"
    t.integer "district"
    t.string "county_name"
  end

  create_table "counties", force: :cascade do |t|
    t.string "county_name"
    t.integer "county_fips"
    t.json "feature"
  end

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
    t.json "debt_reporting_location_1"
    t.json "debt_reporting_location_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "debt_reporting_location_1_lat"
    t.float "debt_reporting_location_1_long"
    t.float "debt_reporting_location_2_lat"
    t.float "debt_reporting_location_2_long"
    t.string "debt_reporting_location_1_address"
    t.string "debt_reporting_location_2_address"
    t.string "debt_reporting_location_1_city"
    t.string "debt_reporting_location_2_city"
    t.string "debt_reporting_location_1_state"
    t.string "debt_reporting_location_2_state"
    t.string "debt_reporting_location_1_zipcode"
    t.string "debt_reporting_location_2_zipcode"
    t.integer "state_fips"
    t.integer "county_fips"
    t.integer "district"
    t.string "county_name"
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
    t.json "expense_location_1"
    t.json "expense_location_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "expense_location_1_lat"
    t.float "expense_location_1_long"
    t.float "expense_location_2_lat"
    t.float "expense_location_2_long"
    t.string "expense_location_1_address"
    t.string "expense_location_2_address"
    t.string "expense_location_1_city"
    t.string "expense_location_1_state"
    t.string "expense_location_1_zip"
    t.string "expense_location_2_city"
    t.string "expense_location_2_state"
    t.string "expense_location_2_zip"
    t.integer "state_fips"
    t.integer "county_fips"
    t.integer "district"
    t.string "county_name"
  end

  create_table "filers", force: :cascade do |t|
    t.integer "filer_id"
    t.integer "election_year"
    t.integer "election_cycle"
    t.string "amended_report_indicator"
    t.string "termination_indicator"
    t.integer "filer_type"
    t.string "filer_name"
    t.string "office"
    t.integer "district"
    t.string "party"
    t.string "filer_address_1"
    t.string "filer_address_2"
    t.string "filer_city"
    t.string "filer_state"
    t.string "filer_zipcode"
    t.integer "county"
    t.string "phone_number"
    t.float "beginning_balance"
    t.float "monetary"
    t.float "in_kind"
    t.json "filer_location_1"
    t.json "filer_location_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "filer_location_1_address"
    t.string "filer_location_2_address"
    t.string "filer_location_1_city"
    t.string "filer_location_2_city"
    t.string "filer_location_1_state"
    t.string "filer_location_2_state"
    t.string "filer_location_1_zip"
    t.string "filer_location_2_zip"
    t.float "filer_location_1_lat"
    t.float "filer_location_1_long"
    t.float "filer_location_2_lat"
    t.float "filer_location_2_long"
    t.integer "state_fips"
    t.integer "county_fips"
    t.string "county_name"
  end

  create_table "house_districts", force: :cascade do |t|
    t.string "h_first_name"
    t.string "h_last_name"
    t.string "home_county"
    t.string "party"
    t.integer "legislative_district"
    t.json "feature"
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
    t.json "receipt_location_1"
    t.json "receipt_location_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "receipt_location_1_address"
    t.string "receipt_location_1_city"
    t.string "receipt_location_1_state"
    t.string "receipt_location_1_zip"
    t.string "receipt_location_2_address"
    t.string "receipt_location_2_city"
    t.string "receipt_location_2_state"
    t.string "receipt_location_2_zip"
    t.float "receipt_location_1_lat"
    t.float "receipt_location_1_long"
    t.float "receipt_location_2_lat"
    t.float "receipt_location_2_long"
    t.integer "state_fips"
    t.integer "county_fips"
    t.integer "district"
    t.string "county_name"
  end

  create_table "senate_districts", force: :cascade do |t|
    t.string "s_first_name"
    t.string "s_last_name"
    t.string "home_county"
    t.string "party"
    t.integer "legislative_district"
    t.json "feature"
  end

end
