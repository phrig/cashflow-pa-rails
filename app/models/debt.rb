class Debt < ApplicationRecord
  include ActionView::Helpers::UrlHelper
  require 'geokit'

  belongs_to :filer, foreign_key: 'filer_id'
  belongs_to :filer, foreign_key: 'election_cycle'

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

  def self.get_nearby(lat, long, dist)

    lat_ranges = RangeFinder::find_lat_range(lat, dist)
    long_ranges = RangeFinder::find_long_range(lat, long, dist)

    debts = Debt.includes(:filer)
                .where('debt_reporting_location_1_lat <= ?', lat_ranges[:max_lat])
                .where('debt_reporting_location_1_lat >= ?', lat_ranges[:min_lat])
                .where('debt_reporting_location_1_long <= ?', long_ranges[:max_long])
                .where('debt_reporting_location_1_long >= ?', long_ranges[:min_long])

    center = Geokit::LatLng.new(lat, long)

    distances = debts.map do |debt|
      center.distance_to(debt.lat_lng)
    end

    debts.zip(distances)
  end

  def lat_lng
    lat_lng = []
    lat_lng.push(debt_reporting_location_1_lat).push(debt_reporting_location_1_long)
  end

  def lat_lng
    lat_lng = []

    # Check as sometimes lat/long is null in DB
    if !debt_reporting_location_1_lat.to_s.empty?
      lat=debt_reporting_location_1_lat
    elsif !debt_reporting_location_2_lat.to_s.empty?
      lat=debt_reporting_location_2_lat
    else
      lat=filer.filer_location_1_lat
    end

    if !debt_reporting_location_1_long.to_s.empty?
      long=debt_reporting_location_1_long
    elsif !debt_reporting_location_2_long.to_s.empty?
      long=debt_reporting_location_2_long
    else
      long=filer.filer_location_1_long
    end

    lat_lng.push(lat).push(long)
  end






  def description
    "<em>#{debt_accrual_date}</em><br />
    <strong>Debt</strong> $#{sprintf('%.2f', debt_amount)} <br />
    <strong>Incurred by</strong> #{link_to filer.filer_name, Rails.application.routes.url_helpers.filer_path(filer.id)}<br />
    <strong>Description</strong> #{ debt_description}"
  end
end