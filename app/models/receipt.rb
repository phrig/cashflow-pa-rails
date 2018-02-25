class Receipt < ApplicationRecord
  include TransactionConcern
  require 'geokit'

  def self.get_nearby(lat, long, dist)

    lat_ranges = RangeFinder::find_lat_range(lat, dist)
    long_ranges = RangeFinder::find_long_range(lat, long, dist)

    receipts = Receipt.where('receipt_location_1_lat <= ?', lat_ranges[:max_lat])
                      .where('receipt_location_1_lat >= ?', lat_ranges[:min_lat])
                      .where('receipt_location_1_long <= ?', long_ranges[:max_long])
                      .where('receipt_location_1_long >= ?', long_ranges[:min_long])
    receipts

    center = Geokit::LatLng.new(lat, long)

    distances = receipts.map do |receipt|
      center.distance_to(receipt.lat_lng)
    end

    receipts.zip(distances)
  end

  def lat_lng
    lat_lng = []
    lat_lng.push(receipt_location_1_lat).push(receipt_location_1_long)
  end

  def description
    description = "<em>#{receipt_date&.strftime("%m/%d/%Y")}</em><br />
    <strong>Receipt</strong> $#{sprintf('%.2f', receipt_amount)} <br />
    <strong>To</strong> #{filer.filer_name}<br />"
    if receipt_description.to_s.empty?
      description << ""
    else
      description << "<strong>Description</strong>#{receipt_description}"
    end
  end
end
