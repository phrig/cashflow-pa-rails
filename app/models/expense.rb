class Expense < ApplicationRecord
  include TransactionConcern
  include ActionView::Helpers::UrlHelper
  include RangeFinder
  require 'geokit'

  def self.get_nearby(lat, long, dist)

    lat_ranges = RangeFinder::find_lat_range(lat, dist)
    long_ranges = RangeFinder::find_long_range(lat, long, dist)

    expenses = Expense.where('expense_location_1_lat <= ?', lat_ranges[:max_lat])
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
    lat_lng.push(expense_location_1_lat).push(expense_location_1_long)
  end

  def description
    "<em>#{expense_date&.strftime("%m/%d/%Y")}</em><br />
    <strong>Expense</strong> $#{sprintf('%.2f', expense_amount)}<br />
    <strong>From</strong> #{link_to filer.filer_name, Rails.application.routes.url_helpers.filer_path(filer.id)}<br />
    <strong>To</strong> #{name}<br />
    <strong>Description</strong> #{expense_description}"
  end
end
