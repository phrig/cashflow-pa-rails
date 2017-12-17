module TransactionSearchConcern
  extend ActiveSupport::Concern

  def get_transactions(result_lat, result_lng, distance)
    transactions = []

    expenses = Expense.get_nearby_expenses(result_lat, result_lng, distance)
    debts = Debt.get_nearby(result_lat, result_lng, distance)
    receipts = Receipt.get_nearby(result_lat, result_lng, distance)
    contributions = Contribution.get_nearby(result_lat, result_lng, distance)

    expenses.map{ |expense| transactions.push(expense) }
    debts.map{ |debt| transactions.push(debt) }
    receipts.map{ |receipt| transactions.push(receipt) }
    contributions.map{ |contribution| transactions.push(contribution) }

    transactions
  end
end
