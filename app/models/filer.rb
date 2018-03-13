require 'geocoder'

class Filer < ApplicationRecord
  include ActionView::Helpers::UrlHelper
  include LocationSearchConcern

  has_many :contributions, through: :filers_contributions
  has_many :debts, through: :filers_debts
  has_many :expenses, through: :filers_expenses
  has_many :receipts, through: :filers_receipts

  def expanded_filer_type
    case filer_type_code
    when 'IEC'
      'Independent Expenditure Committee'
    when 'CPC'
      'Candidate\'s Political Committee'
    when 'PAC'
      'Political Action Committee'
    when 'PLC'
      'Political Party Committee'
    when 'MCC'
      'ACBA JUDICIAL EXCELLENCE COMMITTEE'
    when 'Lobbyist'
      'Lobbyist'
    else
      'Unknown'
    end
  end

  def transactions
    transactions = []

    expenses = Expense.where(filer_id: filer_id, election_cycle: election_cycle)
    debts = Debt.where(filer_id: filer_id, election_cycle: election_cycle)
    receipts = Receipt.where(filer_id: filer_id, election_cycle: election_cycle)
    contributions = Contribution.where(filer_id: filer_id, election_cycle: election_cycle)

    transactions
      .concat(expenses)
      .concat(debts)
      .concat(receipts)
      .concat(contributions)
  end

  def lat_lng
    lat_lng = []

    # Check as sometimes lat/long is null in DB
    if !filer_location_1_lat.to_s.empty? && !filer_location_1_long.to_s.empty? && filer_location_1_lat>=-66
      lat=filer_location_1_lat
      long=filer_location_1_long
    elsif !filer_location_2_lat.to_s.empty? && !filer_location_2_long.to_s.empty? && filer_location_2_lat>=-66
      lat=filer_location_2_lat
      long=filer_location_2_long
    else
      if filer_location_1_zip!=nil
        search=filer_location_1_zip + ", United States of America"
        rough_location = safe_geocode_search(search).first
        lat = rough_location.geometry['location']['lat']
        long = rough_location.geometry['location']['lng']
      end
    end

    lat_lng.push(lat).push(long)
  end

  def description
    "<strong>Filer</strong> #{link_to filer_name, Rails.application.routes.url_helpers.filer_path(id)}<br />"
  end
end
