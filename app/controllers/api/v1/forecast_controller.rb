class Api::V1::ForecastController < ApplicationController
  def index
    lat, lng = Geocoder.geocode(params[:location])
    forecast = WeatherFacade.weather(lat, lng)
    

    render status: 200, json: forecast.to_json
  end
end