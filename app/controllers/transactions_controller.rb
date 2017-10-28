class TransactionsController < ApplicationController
  require 'json'

  def show

    type_query = params['type']
    point = params['point']
    distance = params['search_distance']

    type_class = type_query.singularize.capitalize.constantize

    # unless VALID_MODELS.include?(type_class)
    #   raise TypeError, "Unknown transaction type: #{type_class}"
    # end

    transactions = type_class.get_nearby_expenses(point['latitude'], point['longitude'], distance)

    results = { }

    results[:transactions] = []

    transactions.map do |transaction|
      transaction_obj = {}
      transaction_obj[:name] = transaction.name
      transaction_obj[:point] = {longitude: transaction.expense_location_1_long, latitude: transaction.expense_location_2_lat }
      results[:transactions].push(transaction_obj)
    end

    respond_to do |format|
      format.json { render json: results }
    end

  end

  private

  def transaction_params
    params.permit(:type, :lat_long, :dist)
  end

end
