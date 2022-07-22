class Api::UsersController < ApplicationController
  def create
    if User.exists?(user_name: user_params[:user_name])
      return render json: { success: false, message: 'Username is already taken' }, status: :unprocessable_entity
    end

    @user = User.new(user_params)
    if @user.save
      # cookies[:user_name] = user_params[:user_name]
      response.headers['Set-Cookie'] =
        "user_name=#{user_params[:user_name]}; path=/"
      render json: { success: true, message: 'User created successfully', user: @user }, status: :created
    else
      render json: { success: false, message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def authenticate
    @user = User.where(user_name: params[:user_name])
    if @user.present?
      # cookies[:user_name] = params[:user_name]
      response.headers['Set-Cookie'] =
        "user_name=#{params[:user_name]}; path=/"
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
    cookies[:user_name] = 'bobbob'
    p cookies, '__COOKIE__'
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email)
  end
end
