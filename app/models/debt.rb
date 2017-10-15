class Debt < ApplicationRecord

  def to_geojson

    unless debt_reporting_location_2.blank?
      coordinates = [debt_reporting_location_2_long, debt_reporting_location_2_lat]
    else
      coordinates = [debt_reporting_location_1_long, debt_reporting_location_1_lat]
    end
    feature_object = {}

    feature_object[:type] = "Feature"
    feature_object[:geometry] = {}
    feature_object[:geometry][:type] = "Point"
    feature_object[:geometry][:coordinates] = coordinates

    feature_object[:properties] = {}
    feature_object[:properties][:filer_id] = filer_id
    feature_object[:properties][:election_year] = election_year
    feature_object[:properties][:election_cycle] = election_cycle
    feature_object[:properties][:debt_reporter_name] = debt_reporter_name
    feature_object[:properties][:debt_reporting_address_1] = debt_reporting_address_1
    feature_object[:properties][:debt_reporting_address_2] = debt_reporting_address_2
    feature_object[:properties][:debt_reporting_city] = debt_reporting_city
    feature_object[:properties][:debt_reporting_state] = debt_reporting_state
    feature_object[:properties][:debt_reporting_zipcode] = debt_reporting_zipcode
    feature_object[:properties][:debt_accrual_date] = debt_accrual_date
    feature_object[:properties][:debt_amount] = debt_amount
    feature_object[:properties][:debt_description] = debt_description
    feature_object[:properties][:debt_reporting_location_1] = debt_reporting_location_1
    feature_object[:properties][:debt_reporting_location_2] = debt_reporting_location_2
    feature_object[:properties][:debt_reporting_location_1_lat] = debt_reporting_location_1_lat
    feature_object[:properties][:debt_reporting_location_1_long] = debt_reporting_location_1_long
    feature_object[:properties][:debt_reporting_location_1_address] = debt_reporting_location_1_address
    feature_object[:properties][:debt_reporting_location_2_address] = debt_reporting_location_2_address
    feature_object[:properties][:debt_reporting_location_1_city] = debt_reporting_location_1_city
    feature_object[:properties][:debt_reporting_location_2_city] = debt_reporting_location_2_city
    feature_object[:properties][:debt_reporting_location_1_state] = debt_reporting_location_1_state
    feature_object[:properties][:debt_reporting_location_2_state] = debt_reporting_location_2_state
    feature_object[:properties][:debt_reporting_location_1_zipcode] = debt_reporting_location_1_zipcode
    feature_object[:properties][:debt_reporting_location_2_zipcode] = debt_reporting_location_2_zipcode

    return feature_object
  end

end
