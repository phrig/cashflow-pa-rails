require 'rails_helper'
require 'geocoder'

RSpec.describe FilersController, type: :controller do

  describe '#show' do
    context "when a filer exists" do
      subject(:do_action) { get :show, params: {id: filer.id} }
      let(:filer) { FactoryBot.create(:filer)  }
      it 'is successful' do
        do_action
        expect(response.status).to eq(200)
      end
    end
    context "when a filer doesn't exist" do
      subject(:do_action) { get :show, params: {id: -1} }
      it 'triggers 404' do
        expect{do_action}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
  

end
