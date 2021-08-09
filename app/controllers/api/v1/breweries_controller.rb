class Api::V1::BreweriesController < ApplicationController
  def index
    render status: :bad_request, json: {error: 'need location'} and return if params[:location].blank?
    render status: :bad_request, json: {error: 'quantity needs to be an integer'} and return if params[:quantity].blank? || params[:quantity].to_i.zero?
    
    breweries = BreweryFacade.get_breweries(params[:location], params[:quantity])
    render json: {data: breweries.serialize}
  end
end