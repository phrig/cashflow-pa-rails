class Receipt < ApplicationRecord

  def self.get_nearby(lat, long, dist)

    lat_ranges = RangeFinder::find_lat_range(lat, dist)
    long_ranges = RangeFinder::find_long_range(lat, long, dist)

    receipts = Receipt.where('receipt_location_1_lat <= ?', lat_ranges[:max_lat])
                      .where('receipt_location_1_lat >= ?', lat_ranges[:min_lat])
                      .where('receipt_location_1_long <= ?', long_ranges[:max_long])
                      .where('receipt_location_1_long >= ?', long_ranges[:min_long])
    receipts
  end

  def lat_lng
    lat_lng = []
    lat_lng.push(receipt_location_1_lat).push(receipt_location_1_long)
  end

  def description
    "#{name} received $#{receipt_amount} for #{receipt_description}."
  end
end
