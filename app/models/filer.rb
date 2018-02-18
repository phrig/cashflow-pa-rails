class Filer < ApplicationRecord

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

end
