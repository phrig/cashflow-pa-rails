require 'rails_helper'
require 'geocoder'

RSpec.describe FilersController, type: :controller do

  describe '#show' do
    let(:filer) { FactoryBot.create(:filer)  }
    subject(:do_action) { get :show, params: {id: filer.id} }
    it 'is successful' do
      do_action
      expect(response.status).to eq(200)
    end
  end
  

end
