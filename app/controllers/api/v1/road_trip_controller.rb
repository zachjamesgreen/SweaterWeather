class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate_user!

  def index
    road_trip = RoadTripFacade.route(road_trip_params[:origin], road_trip_params[:destination])
    render json: {data: road_trip.serialize}
  rescue RoadTripError => e
    render status: :unprocessable_entity, json: {error: e.message}
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end

  def authenticate_user!
    user = User.find_by(api_key: road_trip_params[:api_key])
    render status: :unauthorized, json: {error: 'user not found'} and return if user.nil?
  end
end