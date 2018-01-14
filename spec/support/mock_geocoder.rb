# based on https://gist.github.com/glittershark/11e39bf5808fffffbbc3
require 'geocoder/results/base'
require 'ostruct'

module MockGeocoder

  def self.included(base)
    base.before :each do
      allow(::Geocoder).to receive(:search).and_raise(
        RuntimeError.new 'Use "mock_geocoding!" method in your tests.')
    end
  end

 def mock_geocoding!(options = {})
    options.reverse_merge!(
      address: '1401 John F Kennedy Blvd',
      geometry: { 'location' => { 'lat' => 39.9523789, 'lng' => -75.1635996 } },
      coordinates: [39.9523789, -75.1635996],
      state: 'Pennsylvania',
      state_code: 'State Code',
      country: 'Country',
      country_code: 'Country code'
    )

    MockResult.new.tap do |result|

      if options[:fake_location] == true # Mock nil response from Geocoder for failed lookups
        result = nil
      else
        result = OpenStruct.new(options)
      end

      allow(Geocoder).to receive(:search).and_return([result])
    end
  end

  class MockResult < ::Geocoder::Result::Base
    def initialize(data = [])
      super(data)
    end
  end
end
