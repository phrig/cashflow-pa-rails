class Expense < ApplicationRecord
  include TransactionConcern
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
    "Expense: #{filer_id} (Filer_id) paid $#{sprintf('%.2f', expense_amount)} to #{name} on #{expense_date&.strftime("%m/%d/%Y")} for <em>#{expense_description}</em>."
  end

  def icon
    {
      icon_url: 'assets/icon-yellow-minus.png',
      shadow_url: 'assets/marker-shadow.png',
      icon_size: [25, 41],
      shadow_size: [41, 41],
      icon_anchor: [12, 41],
      shadow_anchor: [12, 41],
      popup_anchor: [0, -34]
    }
  end
  
end
