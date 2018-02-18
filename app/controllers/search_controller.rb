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
    transactions.each do |transaction|
      transaction.filer
    end
  end

  def search_params
    params.permit(:query)
  end
end
