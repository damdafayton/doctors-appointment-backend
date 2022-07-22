class Api::UsersController < ApplicationController
  def create
    if User.exists?(username: user_params[:username])
      return render json: { success: false, message: 'Username is already taken' }, status: :unprocessable_entity
    end

    @user = User.new(user_params)
    if @user.save
      # cookies[:username] = user_params[:username]
      response.headers['Set-Cookie'] =
        "username=#{user_params[:username]}; path=/"
      render json: { success: true, message: 'User created successfully', user: @user }, status: :created
    else
      render json: { success: false, message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def authenticate
    @user = User.where(username: params[:username])
    if @user.present?
      # cookies[:username] = params[:username]
      response.headers['Set-Cookie'] =
        "username=#{params[:username]}; path=/"
      render json: { success: true, message: 'User logged in successfully', user: @user }, status: :ok
    else
      render json: { success: false, message: 'User not found' }, status: :not_found
    end
  end

  def logout
    de_authenticate_user
    render json: { success: true, message: 'User logged out successfully' }, status: :ok
  end

  def test_login
    cookies[:username] = 'bobbob'
    p cookies, '__COOKIE__'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
