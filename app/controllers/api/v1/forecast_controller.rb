class Api::V1::ForecastController < ApplicationController
  def index
    render status: :bad_request, json: { error: 'need city and state' } and return unless params[:location].present?

    lat, lng = Geocoder.geocode(params[:location])
    current, daily, hourly = WeatherFacade.weather(lat, lng)
    
    render status: 200, json: {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: current,
          daily_weather: daily,
          hourly_weather: hourly
        }
      }
    }
  end
end