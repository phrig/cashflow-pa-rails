module TransactionSearchConcern
  extend ActiveSupport::Concern

  def get_transactions(result_lat, result_lng, distance)
    transactions = []

    @expenses = Expense.get_nearby(result_lat, result_lng, distance)
    @debts = Debt.get_nearby(result_lat, result_lng, distance)
    @receipts = Receipt.get_nearby(result_lat, result_lng, distance)
    @contributions = Contribution.get_nearby(result_lat, result_lng, distance)

    transactions
      .concat(@expenses)
      .concat(@debts)
      .concat(@receipts)
      .concat(@contributions)
      .sort_by(&:last)
      .map(&:first)
  end
end
