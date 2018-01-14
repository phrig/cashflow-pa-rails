require 'rails_helper'
require 'geocoder'

RSpec.describe SearchController, type: :controller do

  describe "#search_results" do
    let(:query) { {query: "19102"} }
    subject(:do_action) {get :search_results, params: query }

    context "when a result is in Pennsylvania" do
      before { mock_geocoding! }
      it "is successful" do
        expect(do_action.response_code).to eq(200)
      end

      it "loads the PA map data" do
        do_action
        expect(assigns(:pa_state_geojson)).to_not be(nil)
      end

      it 'does not return an error' do
        do_action
        expect(assigns(:location_error)).to eq( { error: false } )
      end
    end


end
