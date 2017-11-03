class CandidatesController < ApplicationController
  require 'geokit'
  require 'json'

  def get_district_data(query_point) # TODO: Handle nils, errors, etc.

    candidate_results = []

    senate_results = SenateDistrict.get_district_data(query_point)
    house_results = HouseDistrict.get_district_data(query_point)
    congressional_results = CongressionalDistrict.get_district_data(query_point)

    candidate_results.push(senate_results, house_results, congressional_results)
  end

  def show
    query_point = eval(params['point'])

    results_hash = {}
    results_hash['candidate_types'] = get_district_data(query_point)

    respond_to do |format|
      format.json { render json: results_hash }
    end

  end
end
