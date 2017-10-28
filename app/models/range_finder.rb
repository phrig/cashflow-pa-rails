module RangeFinder
  include Math

  def self.find_lat_range(lat, dist)

    dist_degree = dist.to_f/69 # 1 mile == 1/69th degrees

    results = {}

    results[:max_lat] = lat + dist_degree
    results[:min_lat] = lat - dist_degree

    results
  end

  def self.find_long_range(lat, long, dist)

    long_range = dist.to_f * ( 180 / ( PI * 3959 * Math.cos( lat * (PI / 180) ) ) )

    results = {}

    results[:max_long] = long + long_range
    results[:min_long] = long - long_range

    results
  end

end
