class Api::V1::UsersController < ApplicationController


  # POST /users or /users.json
  def create
    if check_password
      @user = User.create(user_params)
      render json: @user.reload, status: :created
    else
      render json: {errors: 'Something went wrong'}, status: :unprocessable_entity
    end
  end

  private

  def check_password
    check = false
    if params['password'] == params['password_confirmation']
      check = true
    end
    check
  end

  def user_params
    params.permit(:email, :password)
  end
end
