class SenateDistrict < ApplicationRecord

  def self.get_district_data(query_point)
    results = []
    SenateDistrict.all.map do |district|
      feature = district.feature
      points = []

      feature['geometry']['coordinates'].first.map do |point|
        points.push(Geokit::LatLng.new(point[1], point[0]))
      end

      polygon = Geokit::Polygon.new(points)

      check_point = Geokit::LatLng.new(query_point[:latitude], query_point[:longitude])

      if polygon.contains?(check_point)
        results.push(district)
      end
    end
    return SenateDistrict.response_object(results)
  end

  def self.response_object(results)
    senate_hash = {}
    senate_hash[:type] = 'Senate'
    senate_hash['Candidates'] = []

    results.map do |result|
      senate_info = {}
      senate_info[:name] = "#{result.s_first_name} #{result.s_last_name}"
      senate_info[:home_county] = result.home_county
      senate_info[:legislative_district] = result.legislative_district
      senate_info[:district_shape] = result.feature['geometry']

      senate_hash['Candidates'].push(senate_info)
    end
    senate_hash
  end

end