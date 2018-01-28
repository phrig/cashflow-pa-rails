# TODO: Modify values as needed

FactoryBot.define do
  factory :debt do
    filer_id 12345678
    election_year 2017
    election_cycle 1
    debt_reporter_name 'Rocky Balboa'
    debt_reporting_address_1 '3604 Chestnut St'
    #debt_reporting_address_2
    debt_reporting_city 'Philadelphia'
    debt_reporting_state 'Pennsylvania'
    debt_reporting_location_1_zipcode '19104'
    debt_accrual_date '2017-04-25'
    debt_amount 40000.0
    debt_description 'Hoagies'
    debt_reporting_location_1 "{ type: 'Point', coordinates: [-75.194879, 39.954568] }".to_json
    # debt_reporting_location_2
    debt_reporting_location_1_lat 39.954568
    debt_reporting_location_1_long -75.194879
    # debt_reporting_location_2_lat
    # debt_reporting_location_2_long
    # debt_reporting_location_1_address
    # debt_reporting_location_2_address
    # debt_reporting_location_1_city
    # debt_reporting_location_2_city
    # debt_reporting_location_1_state
    # debt_reporting_location_2_state
    # debt_reporting_location_1_zipcode
    # debt_reporting_location_2_zipcode
    # state_fips
    # county_fips
    # district
    # county_name
  end
end
