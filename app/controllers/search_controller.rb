require 'geocoder'

class SearchController < ApplicationController
  include LocationSearchConcern
  include TransactionSearchConcern

  before_action :search_params

  def icon_characteristics
    {
      icon_url: 'assets/leaf-green.png',
      shadow_url: 'assets/leaf-shadow.png',
      icon_size: [38, 95],
      shadow_size: [50, 64],
      icon_anchor: [22, 94],
      shadow_anchor: [4, 62],
      popup_anchor: [-3, -76]
    }
  end

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
      
      @markers = transactions.map do |transaction|
        { latlng: transaction.lat_lng, popup: transaction.description, icon: icon_characteristics }
      end

      @location_error = { error: false }

    else
      @location_error = {
        error: true, message: 'You searched for a location outside Pennsylvania.'
      }
    end
  end

  private

  def search_params
    params.permit(:query)
  end
end
