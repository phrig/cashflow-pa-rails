class CandidatesController < ApplicationController
  require 'geokit'
  require 'json'

  def get_senate_district(query_point)

    SenateDistrict.all.map do |district|
      feature = district.feature
      points = []

      feature['geometry']['coordinates'].first.map do |point|
        points.push(Geokit::LatLng.new(point[1], point[0]))
      end

      polygon = Geokit::Polygon.new(points)

      check_point = Geokit::LatLng.new(query_point[:latitude], query_point[:longitude])

      if polygon.contains?(check_point)
        @result = district
      end
    end
    return @result

  end

  def show
    query_point = eval(params['point'])

    district = get_senate_district(query_point)

    response_data = { }

    response_data[:candidate_types] = []

    senate_hash = {}

    senate_hash[:type] = 'senate'
    senate_hash[:candidates] = []

    senate_info = {}
    senate_info[:s_first_name] = district.s_first_name
    senate_info[:s_last_name] = district.s_last_name
    senate_info[:home_county] = district.home_county
    senate_info[:legislative_district] = district.legislative_district
    senate_info[:feature] = district.feature

    senate_hash[:candidates].push( senate_info )
    response_data[:candidate_types].push( senate_hash )

    respond_to do |format|
      format.json { render json: response_data }
    end

  end
end
