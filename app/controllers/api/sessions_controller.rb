class Api::SessionsController < ApplicationController
  def show
    @user = current_user
    if @user
      render json: @user
    else
      render json: { user: nil }
    end
  end

  def create
      username = params[:username]
      password = params[:password]
      @user = User.find_by_credentials(username, password)
      # @user = User.find_by_credentials(params[:credential], params[:password])
      if @user
        login!(@user)
        render json: @user
      else
        render json: { errors: ['The provided credentials were invalid.'] }, status: :unauthorized
      end
  end

  def destroy
    logout!
    render json: { message: 'success' }
  end
end
