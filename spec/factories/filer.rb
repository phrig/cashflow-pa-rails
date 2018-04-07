# TODO: Modify values as needed
FactoryBot.define do
  factory :filer do
    filer_id 1
    election_year 2017
    election_cycle 2
    amended_report_indicator 'Y'
    # termination_indicator
    filer_type 2
    sequence(:filer_name) { |n| "Filer Name #{n}" }
    # office
    # district
    # party
    # filer_address_1
    # filer_address_2
    # filer_city
    # filer_state
    # filer_zipcode
    # county
    # phone_number
    # beginning_balance
    # monetary
    # in_kind
    # filer_location_1
    # filer_location_2
    # created_at
    # updated_at
    # filer_location_1_address
    # filer_location_2_address
    # filer_location_1_city
    # filer_location_2_city
    # filer_location_1_state
    # filer_location_2_state
    # filer_location_1_zip
    # filer_location_2_zip
    # filer_location_1_lat
    # filer_location_1_long
    # filer_location_2_lat
    # filer_location_2_long
    # state_fips
    # county_fips
    # county_name
    # filer_type_code
  end
end