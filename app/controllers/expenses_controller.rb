class ExpensesController < ApplicationController

  def index
    @expenses = Expense.all.limit(50)

    render json: @expenses, status: 200
  end

end
