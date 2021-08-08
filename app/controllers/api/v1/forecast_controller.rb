class Api::V1::ForecastController < ApplicationController
  def index
    render status: 200, json: {yes: 'yes'}
  end
end