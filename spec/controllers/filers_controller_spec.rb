require 'rails_helper'
require 'geocoder'

RSpec.describe FilersController, type: :controller do

  describe '#show' do
    context 'when a filer exists' do
      subject(:do_action) { get :show, params: { id: filer.id } }
      let(:filer) { FactoryBot.create(:filer) }
      it 'is successful' do
        do_action
        expect(response.status).to eq(200)
      end
    end

    context "when a filer doesn't exist" do
      subject(:do_action) { get :show, params: { id: -1 } }
      it 'triggers 404' do
        expect{ do_action }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when a filer has related filers' do
      let!(:filer) { FactoryBot.create(:filer) }
      let!(:related_filers) { FactoryBot.create_list(:filer, 3, filer_id: filer.filer_id) }
      subject(:do_action) { get :show, params: { id: filer.id } }
      it 'returns the right number of related filers' do
        do_action
        expect(assigns(:related_filers).length).to be(4)
      end
    end

    context 'when a filer has transactions' do
      let!(:filer) { FactoryBot.create(:filer) }
      let!(:debts) { FactoryBot.create_list(
                                            :debt, 3, filer_id: filer.filer_id,
                                            election_cycle: filer.election_cycle) }
      let!(:expenses) { FactoryBot.create_list(
                                               :expense, 4, filer_id: filer.filer_id,
                                               election_cycle: filer.election_cycle) }
      before do
        debts.each{ |debt| FactoryBot.create(:filers_debts, filer_id: filer.id, debt_id: debt.id) }
        expenses.each{ |expense| FactoryBot.create(:filers_expenses, filer_id: filer.id,
                                                   expense_id: expense.id) }
      end

      subject(:do_action) { get :show, params: { id: filer.id } }
      it 'returns the right number of transactions' do
        do_action
        expect(assigns(:transactions).length).to be(7)
      end
    end
  end
end
