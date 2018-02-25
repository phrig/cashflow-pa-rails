require 'rails_helper'
require 'geocoder'

RSpec.describe SearchController, type: :controller do

  describe '#search_results' do
    let(:query) { { query: '19102' } }
    subject(:do_action) { get :search_results, params: query }

    context 'when a result is in Pennsylvania' do
      before { mock_geocoding! }
      it 'is successful' do
        expect(do_action.response_code).to eq(200)
      end

      it 'loads the PA map data' do
        do_action
        expect(assigns(:pa_state_geojson)).to_not be(nil)
      end

      it 'does not return an error' do
        do_action
        expect(assigns(:location_error)).to eq( { error: false } )
      end

      context 'when there are transactions' do
        let!(:filer) { FactoryBot.create(:filer) }
        let!(:local_debt) { FactoryBot.create(:debt, filer_id: filer.filer_id,
                                              election_cycle: filer.election_cycle) }
        let!(:local_expense) { FactoryBot.create(:expense, filer_id: filer.filer_id,
                                                 election_cycle: filer.election_cycle) }
        let!(:far_debt) { FactoryBot.create(:debt,
          debt_reporting_location_1_lat: 45.522781, debt_reporting_location_1_long: -122.6779265 ) }

        context 'when there are nearby transactions' do
          it 'returns two nearby transactions' do
            do_action
            lat_lngs = assigns(:markers).map{ |hash| hash[:latlng] }
            expect(lat_lngs).to contain_exactly(local_debt.lat_lng, local_expense.lat_lng)
          end

          it 'returns the correct transaction descriptions' do
            do_action
            popups = assigns(:markers).map{ |hash| hash[:popup] }
            # Could use more precise test
            expect(popups.first).to include(
              "Expense"
            )
          end
        end

        it 'does not return transactions from far away' do
          do_action
          expect(assigns(:markers).map{ |hash| hash[:latlng] }).not_to include(far_debt.lat_lng)
        end
      end
    end

    context 'when a result is not in PA' do
      before { mock_geocoding!({ state: 'Oregon' }) }
      let(:query) { { query: '97754' } }

      it 'is successful' do
        expect(do_action.response_code).to eq(200)
      end

      it 'loads the PA map data' do
        do_action
        expect(assigns(:pa_state_geojson)).to_not be(nil)
      end

      it 'returns an error with a message' do
        do_action
        expect(assigns(:location_error)).to eq( { error: true,
          message: 'You searched for a location outside Pennsylvania.' } )
      end
    end

    context 'when a location does not exist' do
      before { mock_geocoding!({ fake_location: true }) }
      let(:query) { { query: 'fake_location' } }

      it 'is successful' do
        expect(do_action.response_code).to eq(200)
      end

      it 'loads the PA map data' do
        do_action
        expect(assigns(:pa_state_geojson)).to_not be(nil)
      end

      it 'returns an error with a message' do
        do_action
        expect(assigns(:location_error)).to eq( { error: true,
          message: 'Could not find the location you searched for. Please try again.' } )
      end
    end
  end

end
