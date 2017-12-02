require 'geocoder'

class SearchController < ApplicationController
	before_action :search_params

	def get_results
		@location=Geocoder.search(search_params[:query])
		if @location
			render "results"
		else
			raise "#{search_params.inspect}Boo"
		end
	end

	private

	def search_params
		params.permit(:query)
	end
end