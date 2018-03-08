class Expense < ApplicationRecord
  include ActionView::Helpers::UrlHelper
  include RangeFinder
  require 'geokit'

  belongs_to :filer, foreign_key: 'filer_id'
  belongs_to :filer, foreign_key: 'election_cycle'

  def self.get_nearby(lat, long, dist)

    lat_ranges = RangeFinder::find_lat_range(lat, dist)
    long_ranges = RangeFinder::find_long_range(lat, long, dist)

    expenses = Expense.includes(:filer)
                      .where('expense_location_1_lat <= ?', lat_ranges[:max_lat])
                      .where('expense_location_1_lat >= ?', lat_ranges[:min_lat])
                      .where('expense_location_1_long <= ?', long_ranges[:max_long])
                      .where('expense_location_1_long >= ?', long_ranges[:min_long])

    center = Geokit::LatLng.new(lat, long)

    distances = expenses.map do |expense|
      center.distance_to(expense.lat_lng)
    end

    expenses.zip(distances)
  end

  def lat_lng
    lat_lng = []

    # Check as sometimes lat/long is null in DB
    unless expense_location_1_lat.to_s.empty?
      lat=expense_location_1_lat
    else
      lat=expense_location_2_lat
    end

    unless expense_location_1_long.to_s.empty?
      long=expense_location_1_long
    else
      long=expense_location_2_long
    end

    lat_lng.push(lat).push(long)
  end

  def description
    "<em>#{expense_date&.strftime("%m/%d/%Y")}</em><br />
    <strong>Expense</strong> $#{sprintf('%.2f', expense_amount)}<br />
    <strong>From</strong> #{link_to filer.filer_name, Rails.application.routes.url_helpers.filer_path(filer.id)}<br />
    <strong>To</strong> #{name}<br />
    <strong>Description</strong> #{expense_description}"
  end
end
