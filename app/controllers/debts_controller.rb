class DebtsController < ApplicationController

  def index
    @debts = Debt.all.limit(50)

    render json: @debts, status: 200
  end

end
