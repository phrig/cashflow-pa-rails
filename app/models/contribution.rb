class Contribution < ApplicationRecord
  include ActionView::Helpers::UrlHelper
  require 'geokit'

  has_one :filers_contributions
  has_one :filer, through: :filers_contributions

  def self.get_nearby(lat, long, dist)

    lat_ranges = RangeFinder::find_lat_range(lat, dist)
    long_ranges = RangeFinder::find_long_range(lat, long, dist)

    contributions = Contribution.includes(:filer)
                                .where('contributor_location_1_lat <= ?', lat_ranges[:max_lat])
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

    # Check as sometimes lat/long is null in DB
    if !contributor_location_1_lat.to_s.empty? && !contributor_location_1_long.to_s.empty? && contributor_location_1_lat>=-66
      lat=contributor_location_1_lat
      long=contributor_location_1_long
    elsif !contributor_location_2_lat.to_s.empty? && !contributor_location_2_long.to_s.empty? && contributor_location_2_lat>=-66
      lat=contributor_location_2_lat
      long=contributor_location_2_long
    elsif !employer_location_1_lat.to_s.empty? && !employer_location_1_long.to_s.empty? && employer_location_1_lat>=-66
      lat=employer_location_1_lat
      long=employer_location_1_long
    elsif !employer_location_2_lat.to_s.empty? && !employer_location_2_long.to_s.empty? && employer_location_2_lat>=-66
      lat=employer_location_2_lat
      long=employer_location_2_long
    elsif !filer.filer_location_1_lat.to_s.empty? && !filer.filer_location_1_long.to_s.empty?
      lat=filer.filer_location_1_lat
      long=filer.filer_location_1_long
    else
      lat=filer.filer_location_2_lat
      long=filer.filer_location_2_long
    end

    lat_lng.push(lat).push(long)
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