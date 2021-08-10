class Api::V1::ForecastController < ApplicationController
  # skip_before_action :ensure_json_request
  
  def index
    render status: :bad_request, json: { error: 'need city and state' } and return unless params[:location].present?

    lat, lng = Geocoder.coords(params[:location])
    current, daily, hourly = WeatherFacade.weather(lat, lng)
    
    render json: ForecastSerializer.serialize(current, daily[0..4], hourly[0..7])
  end
end