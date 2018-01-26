class Expense < ApplicationRecord
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
    "#{name} spent $#{sprintf('%.2f', expense_amount)}."
  end
end
