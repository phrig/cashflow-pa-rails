require 'rails_helper'

RSpec.describe Debt, type: :model do

  describe '.lat_lng' do
    let(:debt) { FactoryBot.create(:debt) }
    let(:lat_lng_arr) { [debt.debt_reporting_location_1_lat, debt.debt_reporting_location_1_long] }
    it 'returns an array with the right lat and long' do
      expect(debt.lat_lng).to match_array(lat_lng_arr)
    end
  end
end
