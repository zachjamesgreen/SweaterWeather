class Api::V1::RoadTripController < ApplicationController
  # before_action :authenticate_user!

  def index
    render status: :unprocessable_entity, json: { error: 'this route only takes json data' } and return if request.content_type != 'application/json'

    body = JSON.parse(request.raw_post)
    user = User.find_by(api_key: body['api_key'])
    render status: :unauthorized, json: { error: 'user not found' } and return  if user.nil?

    road_trip = RoadTripFacade.route(body[:origin], body[:destination])
    render json: {data: road_trip.serialize}
  rescue RoadTripError
    render json: RoadTripSerializer.impossible(body)
  rescue JSON::ParserError
    render status: :unprocessable_entity, json: { error: 'problem parsing request body' }
  end
end