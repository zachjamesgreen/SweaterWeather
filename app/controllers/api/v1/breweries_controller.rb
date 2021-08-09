class Api::V1::BreweriesController < ApplicationController
  def index
    breweries = BreweryFacade.get_breweries(params[:location], params[:quantity])
    render json: breweries.serialize
  end
end