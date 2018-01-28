# TODO: Modify values as needed

FactoryBot.define do
  factory :expense do
    filer_id 12345678
    election_year 2017
    election_cycle 1
    name 'Committee to Elect Ben Franklin'
    expense_address_1 '1600 Locust Street'
    # expense_address_2
    expense_city 'Philadelphia'
    expense_state 'Pennsylvania'
    expense_zipcode '19103'
    expense_date '2017-04-24'
    expense_amount 25000.0
    expense_description 'Hoagies'
    # expense_location_1
    # expense_location_2
    expense_location_1_lat 39.948656
    expense_location_1_long -75.167914
    # expense_location_2_lat
    # expense_location_2_long
    # expense_location_1_address
    # expense_location_2_address
    # expense_location_1_city
    # expense_location_1_state
    # expense_location_1_zip
    # expense_location_2_city
    # expense_location_2_state
    # expense_location_2_zip
    # state_fips
    # county_fips
    # district
    # county_name
  end
end
