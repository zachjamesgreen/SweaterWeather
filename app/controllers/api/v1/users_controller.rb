class Api::V1::UsersController < ApplicationController

  def create
    render status: :unprocessable_entity, json: { error: 'this route only takes json data' } and return if request.content_type != 'application/json'
    
    body = JSON.parse request.raw_post
    if body['password'] == body['password_confirmation']
      @user = User.create(email: body['email'], password: body['password'])
      render json: @user.reload, status: :created
    else
      render json: { errors: 'Something went wrong' }, status: :unprocessable_entity
    end
  rescue JSON::ParserError
    render status: :unprocessable_entity, json: { error: 'problem parsing request body' }
  end
end
