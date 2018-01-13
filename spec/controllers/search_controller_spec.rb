require 'rails_helper'
require 'geocoder'

RSpec.describe SearchController, type: :controller do
  before(:all) do
    Geocoder.configure(:lookup => :test)
    Geocoder::Lookup::Test.add_stub(
        "19102",
        [
        {"address_components"=>
        [{"long_name"=>"1401", "short_name"=>"1401", "types"=>["street_number"]},
        {"long_name"=>"John F Kennedy Boulevard", "short_name"=>"John F Kennedy Blvd", "types"=>["route"]},
        {"long_name"=>"Center City", "short_name"=>"Center City", "types"=>["neighborhood", "political"]},
        {"long_name"=>"Philadelphia", "short_name"=>"Philadelphia", "types"=>["locality", "political"]},
        {"long_name"=>"Philadelphia County", "short_name"=>"Philadelphia County", "types"=>["administrative_area_level_2", "political"]},
        {"long_name"=>"Pennsylvania", "short_name"=>"PA", "types"=>["administrative_area_level_1", "political"]},
        {"long_name"=>"United States", "short_name"=>"US", "types"=>["country", "political"]},
        {"long_name"=>"19102", "short_name"=>"19102", "types"=>["postal_code"]}],
        "formatted_address"=>"1401 John F Kennedy Blvd, Philadelphia, PA 19102, USA",
        "geometry"=>
        {"location"=>{"lat"=>39.9523789, "lng"=>-75.1635996},
        "location_type"=>"ROOFTOP",
        "viewport"=>
        {"northeast"=>{"lat"=>39.9537278802915, "lng"=>-75.1622506197085}, "southwest"=>{"lat"=>39.9510299197085, "lng"=>-75.16494858029151}}},
        "place_id"=>"ChIJyb-70KChxokR5YR1l-Nka5s",
        "types"=>["city_hall", "establishment", "local_government_office", "point_of_interest"]}
     ]
    )
  end


  describe "#search_results" do
    subject(:do_action) {get :search_results, params: {query: "19102"}}
    context "when a result is in Pennsylvania" do
      it "is successful" do
        expect(do_action.response_code).to eq(200)
      end
    end
  end


end
