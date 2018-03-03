require 'geocoder'
require 'will_paginate/array'

class FilersController < ApplicationController
  include LocationSearchConcern
  include TransactionSearchConcern

  before_action :get_filer, :get_markers, only: :show
  before_action :search_params, only: :search_filer_results

  def index
  end

  def show
  end

  def get_filer
    @filer = Filer.find(params[:id])
    @transactions = @filer.transactions

    @result = @filer.filer_zipcode
    @result_lat = @filer.filer_location_1_lat
    @result_lng = @filer.filer_location_1_long
    @transactions_count = @transactions.count

    @markers = get_markers()
    @bounds = get_bounds
    @filers = get_filers(@transactions)
  end

  private

  def get_markers()
    @transactions.map do |transaction|
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

  def search_filer_results
    puts search_params
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

  def get_filers(transactions)
    transactions.map do |transaction|
      transaction.filer
    end
  end

  def search_params
    params.permit(:query)
  end

  def get_bounds
    markers = @markers.reject{ |marker| marker[:latlng].count != 2 }
    points = markers.map{ |marker| marker[:latlng] }
    lats = points.map(&:first)
    lngs = points.map(&:last)
    [[lats.min, lngs.min], [lats.max, lngs.max]]

  end
end