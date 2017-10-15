class DebtsController < ApplicationController

  def index
    @debts = Debt.all.limit(50)

    @feature_collection = {}
    @feature_collection[:type] = "FeatureCollection"
    @feature_collection[:features] = []
    @debts.map{ |debt| @feature_collection[:features] << debt.to_geojson }

    render json: @feature_collection.to_json, status: 200
  end

end
