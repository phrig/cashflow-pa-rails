require 'geocoder'

class FilersController < ApplicationController
  include LocationSearchConcern
  include TransactionSearchConcern

  before_action :get_filer, :get_markers, only: :show

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

  def get_bounds
    results = @markers.reject{
                                |marker| marker[:latlng].nil? ||
                                marker[:latlng].map{ |point| point.nil? }.any?
                              }
    points = results.map{ |marker| marker[:latlng] }
    lats = points.map(&:first)
    lngs = points.map(&:last)
    [[lats.min, lngs.min], [lats.max, lngs.max]]
  end

  def get_filers(transactions)
    transactions.map do |transaction|
      transaction.filer
    end
  end
end