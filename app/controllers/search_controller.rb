require 'geocoder'
require 'will_paginate/array'

class SearchController < ApplicationController
  include LocationSearchConcern
  include TransactionSearchConcern

  before_action :search_params

  def search_results

    File.open('doc/PA_State.geojson', 'r') do |file|
      file.each_line do |line|
        @pa_state_geojson = line
      end
    end

    @result = Geocoder.search(search_params[:query]).first
    unless @result
      @location_error = {
        error: true, message: 'Could not find the location you searched for. Please try again.'
      }
      return
    end

    if in_pennsylvania?(@result)

      @result_lat = @result.geometry['location']['lat']
      @result_lng = @result.geometry['location']['lng']

      transactions = get_transactions(@result_lat, @result_lng, 5)

      @transactions_count = transactions.count

      @markers = get_markers(transactions).paginate(page: params[:page], per_page: 50)
      @bounds = get_bounds
      @filers = get_filers(transactions)

      if @expenses.any?
        @sum_of_expenses = @expenses.map {|expense| expense.first["expense_amount"]}.reduce(:+)

        @largest_expense_amount = @expenses.select {|expense| expense.first["expense_amount"] == @expenses.map {|expense| expense.first["expense_amount"]}.max }

        @largest_expense_filer = @filers.select {|filer| filer.filer_id == @largest_expense_amount[0][0].filer_id}
      end

      if @debts.any?
        @sum_of_debts = @debts.map {|debt| debt.first["debt_amount"]}.reduce(:+)

        @largest_debt_amount = @debts.select {|debt| debt.first["debt_amount"] == @debts.map {|debt| debt.first["debt_amount"]}.max }

        @largest_debt_filer = @filers.select {|filer| filer.filer_id == @largest_debt_amount[0][0].filer_id}
      end

      if @contributions.any?
        @sum_of_contributions = @contributions.map {|contribution| contribution.first["contribution_amount"]}.reduce(:+)

        @largest_contribution_amount = @contributions.select {|contribution| contribution.first["contribution_amount"] == @contributions.map {|contribution| contribution.first["contribution_amount"]}.max }

        @largest_contribution_filer = @filers.select {|filer| filer.filer_id == @largest_contribution_amount[0][0].filer_id}
      end

      if @receipts.any?
        @sum_of_receipts = @receipts.map {|receipt| receipt.first["receipt_amount"]}.reduce(:+)

        @largest_receipt_amount = @receipts.select {|receipt| receipt.first["receipt_amount"] == @receipts.map {|receipt| receipt.first["receipt_amount"]}.max }

        @largest_receipt_filer = @filers.select {|filer| filer.filer_id == @largest_receipt_amount[0][0].filer_id}
      end

      binding.pry

      @location_error = { error: false }


    else
      @location_error = {
        error: true, message: 'You searched for a location outside Pennsylvania.'
      }
    end
  end

  private

  def get_markers(transactions)
    transactions.map do |transaction|
      transaction_type = transaction.class.name.downcase
      {
        latlng: transaction.lat_lng,
        popup: transaction.description,
        id: "#{transaction_type}-#{transaction.id}",
        filer_id: "filer_id-#{transaction.filer_id}",
        marker_type: transaction_type
      }
    end
  end

  def get_bounds
    points = @markers.map { |marker| marker[:latlng] }
    lats = points.map(&:first)
    lngs = points.map(&:last)
    [[lats.min, lngs.min], [lats.max, lngs.max]]
  end

  def get_filers(transactions)
    transactions.map do |transaction|
      transaction.filer
    end
  end

  def search_params
    params.permit(:query)
  end
end
