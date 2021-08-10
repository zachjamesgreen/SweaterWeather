class Api::V1::UsersController < ApplicationController

  def create
    if check_password
      @user = User.create(user_params)
      render json: @user.reload, status: :created
    else
      render json: { errors: 'Something went wrong' }, status: :unprocessable_entity
    end
  end

  private

  def check_password
    params['password'] == params['password_confirmation']
  end

  def user_params
    params.permit(:email, :password)
  end
end
