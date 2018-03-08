class Filer < ApplicationRecord

  has_many :contributions, foreign_key: 'filer_id'
  has_many :contributions, foreign_key: 'election_cycle'
  has_many :debts, foreign_key: 'filer_id'
  has_many :debts, foreign_key: 'election_cycle'
  has_many :expenses, foreign_key: 'filer_id'
  has_many :expenses, foreign_key: 'election_cycle'
  has_many :receipts, foreign_key: 'filer_id'
  has_many :receipts, foreign_key: 'election_cycle'

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
    unless filer_location_1_lat.to_s.empty?
      lat=filer_location_1_lat
    else
      lat=filer_location_2_lat
    end

    unless filer_location_1_long.to_s.empty?
      long=filer_location_1_long
    else
      long=filer_location_2_long
    end

    lat_lng.push(lat).push(long)
  end


end
