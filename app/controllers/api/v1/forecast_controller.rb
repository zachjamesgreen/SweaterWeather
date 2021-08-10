class Api::V1::ForecastController < ApplicationController
  def index
    render status: :bad_request, json: { error: 'need city and state' } and return unless params[:location].present?

    lat, lng = Geocoder.coords(params[:location])
    current, daily, hourly = WeatherFacade.weather(lat, lng)
    
    render status: 200, json: {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: current.serialize,
          daily_weather: daily.map(&:serialize),
          hourly_weather: hourly.map(&:serialize)
        }
      }
    }
  end
end