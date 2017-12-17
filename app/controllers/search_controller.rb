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
    else
      raise "#{search_params.inspect}Boo"
    end
  end

  private

  def search_params
    params.permit(:query)
  end
end