class Api::V1::UsersController < ApplicationController


  # POST /users or /users.json
  def create
    if check_password
      @user = User.create(user_params)
      render json: @user.reload, status: :created
    else
      render json: {errors: 'Something went wrong'}, status: :unprocessable_entity
    end
    

    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to @user, notice: "User was successfully created." }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { redirect_to @user, notice: "User was successfully updated." }
    #     format.json { render :show, status: :ok, location: @user }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    # @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private

  def check_password
    check = false
    if params['password'] == params['password_confirmation']
      check = true
    end
    check
  end
    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:email, :password_digest, :api_key)
    end

    # def user_params
    #   params.require(:user).permit(:email, :password_digest, :api_key)
    # end
end
