require 'geocoder'

class SearchController < ApplicationController
  include LocationSearchConcern

  before_action :search_params

  def search_results

    File.open('doc/PA_State.geojson', 'r') do |file|
      file.each_line do |line|
        @pa_state_geojson = line
      end
    end

    @result = Geocoder.search(search_params[:query]).first
    if @result
      if in_pennsylvania?(@result)
        @result
        @location_error = { error: false }
      else
        @location_error = {
          error: true, message: 'You searched for a location outside Pennsylvania.'
        }
      end
    else
      @location_error = {
        error: true, message: 'Could not find the location you searched for. Please try again.'
      }
    end
  end

  private

  def search_params
    params.permit(:query)
  end
end