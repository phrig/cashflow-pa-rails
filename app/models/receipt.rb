class Receipt < ApplicationRecord
  include TransactionConcern
  include ActionView::Helpers::UrlHelper
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

    # Check as sometimes lat/long is null in DB
    if !receipt_location_1_lat.to_s.empty? && !receipt_location_1_long.to_s.empty?
      lat=receipt_location_1_lat
      long=receipt_location_1_long
    elsif !receipt_location_2_lat.to_s.empty? && !receipt_location_2_long.to_s.empty?
      lat=receipt_location_2_lat
      long=receipt_location_2_long
    elsif !filer.filer_location_1_lat.to_s.empty? && !filer.filer_location_1_long.to_s.empty?
      lat=filer.filer_location_1_lat
      long=filer.filer_location_2_long
    else
      lat=filer.filer_location_2_lat
      long=filer.filer_location_2_long
    end

    lat_lng.push(lat).push(long)
  end

  def description
    description = "<em>#{receipt_date&.strftime("%m/%d/%Y")}</em><br />
    <strong>Receipt</strong> $#{sprintf('%.2f', receipt_amount)} <br />
    <strong>To</strong> #{link_to filer.filer_name, Rails.application.routes.url_helpers.filer_path(filer.id)}<br />"
    if receipt_description.to_s.empty?
      description << ""
    else
      description << "<strong>Description</strong> #{receipt_description}"
    end
  end
end
