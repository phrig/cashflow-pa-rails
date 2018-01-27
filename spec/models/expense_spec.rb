require 'rails_helper'

RSpec.describe Expense, type: :model do

  describe '.lat_lng' do
    let(:expense) { FactoryBot.create(:expense) }
    let(:lat_lng_arr) { [expense.expense_location_1_lat, expense.expense_location_1_long] }
    it 'returns an array with the right lat and long' do
      expect(expense.lat_lng).to match_array(lat_lng_arr)
    end
  end
end
