class Api::V1::SessionsController < ApplicationController
  # POST /api/v1/sessions
  def create
    render status: :unprocessable_entity, json: { error: 'this route only takes json data' } and return if request.content_type != 'application/json'
    
    body = JSON.parse(request.raw_post)
    user = User.find_by(email: body['email'])
    if user && user.authenticate(body['password'])
      render json: user, status: :ok
    else
      render status: :unauthorized, json: { errors: [{ message: 'Invalid email or password' }] }
    end
  rescue JSON::ParserError
    render status: :unprocessable_entity, json: { error: 'problem parsing request body' }
  end

end