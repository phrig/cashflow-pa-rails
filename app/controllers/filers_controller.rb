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
    if @filers==nil || @filers.count<=0
      @initial_center=[40.88555556,-76.26444444]
    else
      @initial_center=@filers.first.lat_lng
    end
  end

  def search_filer_results
    @filer_query=search_params[:query]
    @filers=Filer.where('UPPER(filer_name) like UPPER(?)', "%#{@filer_query}%")

    File.open('doc/PA_State.geojson', 'r') do |file|
      file.each_line do |line|
        @pa_state_geojson = line
      end
    end

    @filer_markers = get_filer_markers()
    @bounds = get_bounds
    if @filers==nil || @filers.count<=0
      @initial_center=[40.88555556,-76.26444444]
    else
      @initial_center=@filers.first.lat_lng
    end
  end

  private

  def get_filers(transactions)
    transactions.map do |transaction|
      transaction.filer
    end
  end

  def search_params
    params.permit(:query)
  end

  def get_bounds
    if @filer_markers!=nil
      markers = @filer_markers
    else
      markers = @markers
    end
    results=markers.reject{
                                |marker| marker[:latlng].nil? ||
                                marker[:latlng].map{ |point| point.nil? }.any?
                              }
    points = results.map{ |marker| marker[:latlng] }
    lats = points.map(&:first)
    lngs = points.map(&:last)
    [[lats.min, lngs.min], [lats.max, lngs.max]]
  end

  def get_filer_markers()
    @filers.map do |filer|
      icon_type = "filer"
      {
        latlng: filer.lat_lng,
        popup: filer.description,
        id: "#{filer.id}",
        filer_id: "filer_id-#{filer.id}",
        marker_type: icon_type
      }
    end
  end

  def get_markers()
    @transactions.map do |transaction|
      transaction_type = transaction.class.name.downcase
      {
        latlng: transaction.lat_lng,
        popup: transaction.description,
        id: "#{transaction_type}-#{transaction.id}",
        filer_id: "#{transaction.filer.id}",
        marker_type: transaction_type
      }
    end
  end
end