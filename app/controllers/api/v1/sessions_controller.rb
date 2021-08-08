class Api::V1::SessionsController < ApplicationController
  # POST /api/v1/sessions
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: user, status: :ok
    else
      render json: { errors: [{ message: 'Invalid email or password' }] }, status: :unauthorized
    end
  end

end