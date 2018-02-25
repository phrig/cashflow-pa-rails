class Contribution < ApplicationRecord
  include TransactionConcern
  include ActionView::Helpers::UrlHelper
  require 'geokit'

  def self.get_nearby(lat, long, dist)

    lat_ranges = RangeFinder::find_lat_range(lat, dist)
    long_ranges = RangeFinder::find_long_range(lat, long, dist)

    contributions = Contribution.where('contributor_location_1_lat <= ?', lat_ranges[:max_lat])
                      .where('contributor_location_1_lat >= ?', lat_ranges[:min_lat])
                      .where('contributor_location_1_long <= ?', long_ranges[:max_long])
                      .where('contributor_location_1_long >= ?', long_ranges[:min_long])

    center = Geokit::LatLng.new(lat, long)

    distances = contributions.map do |contribution|
      center.distance_to(contribution.lat_lng)
    end

    contributions.zip(distances)
  end

  def lat_lng
    lat_lng = []
    lat_lng.push(contributor_location_1_lat).push(contributor_location_1_long)
  end

  def description
    description = "<em>#{contribution_date&.strftime("%m/%d/%Y")}</em><br />
    <strong>Contribution</strong> $#{sprintf('%.2f', contribution_amount)} <br />
    <strong>To</strong> #{link_to filer.filer_name, Rails.application.routes.url_helpers.filer_path(filer.id)}<br />
    <strong>From</strong> #{contributor} <br />"
    if contribution_description.to_s.empty?
      description << ""
    else
      description << "<strong>Description</strong>#{contribution_description}"
    end
  end
end