class Expense < ApplicationRecord
  include RangeFinder

  def self.get_nearby_expenses(lat, long, dist)

    lat_ranges = RangeFinder::find_lat_range(lat, dist)
    long_ranges = RangeFinder::find_long_range(lat, long, dist)

    expenses = Expense.where('expense_location_1_lat <= ?', lat_ranges[:max_lat])
                      .where('expense_location_1_lat >= ?', lat_ranges[:min_lat])
                      .where('expense_location_1_long <= ?', long_ranges[:max_long])
                      .where('expense_location_1_long >= ?', long_ranges[:min_long])
    expenses

  end

end
