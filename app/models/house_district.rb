class HouseDistrict < ApplicationRecord

  def self.get_district_data(query_point)
    results = []
    HouseDistrict.all.map do |district|
      feature = district.feature
      points = []

      feature['geometry']['coordinates'].first.map do |point|
        if point[1].class.name == 'Array'
          point.map do |sub_point|
            points.push(Geokit::LatLng.new(sub_point[1], sub_point[0]))
          end
        else
          points.push(Geokit::LatLng.new(point[1], point[0]))
        end
      end

      polygon = Geokit::Polygon.new(points)

      check_point = Geokit::LatLng.new(query_point[:latitude], query_point[:longitude])

      if polygon.contains?(check_point)
        results.push(district)
      end
    end
    return HouseDistrict.response_object(results)
  end

  def self.response_object(results)
    house_hash = {}
    house_hash[:type] = 'House'
    house_hash['Candidates'] = []

    results.map do |result|
      house_info = {}
      house_info[:h_first_name] = result.h_first_name
      house_info[:h_last_name] = result.h_last_name
      house_info[:home_county] = result.home_county
      house_info[:legislative_district] = result.legislative_district
      house_info[:district_shape] = result.feature['geometry']

      house_hash['Candidates'].push(house_info)
    end
    house_hash
  end

end