require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe '#index' do
    subject(:do_action) { get :index }
    it 'is successful' do
      do_action
      expect(response.status).to eq(200)
    end
  end
end
