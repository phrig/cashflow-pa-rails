class CongressionalDistrict < ApplicationRecord

    def self.get_district_data(query_point)
    results = []
    CongressionalDistrict.all.map do |district|
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
    return CongressionalDistrict.response_object(results)
  end

  def self.response_object(results)
    congressional_hash = {}
    congressional_hash[:type] = 'Congressional'
    congressional_hash['Candidates'] = []

    results.map do |result|
      congressional_info = {}
      congressional_info[:name] = "#{result.c_first_name} #{result.c_last_name}"
      congressional_info[:home_county] = result.home_county
      congressional_info[:legislative_district] = result.legislative_district
      congressional_info[:district_shape] = result.feature['geometry']

      congressional_hash['Candidates'].push(congressional_info)
    end
    congressional_hash
  end

end