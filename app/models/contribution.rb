class Contribution < ApplicationRecord
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
    "Contribution: #{contributor} gave $#{sprintf('%.2f', contribution_amount)} on #{contribution_date.strftime("%m/%d/%Y")}#{contribution_description ? " for" + contribution_description + "." : ". No contribution description provided."} Filer id: #{filer_id}."
  end

end
