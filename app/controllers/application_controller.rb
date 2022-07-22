require 'pry'

class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ErrorHelper
  include SuccessHelper
  @current_user = nil # parse request and check username

  def authenticate_user
    return if cookies[:user_name] == 'nil'

    # binding.pry
    cookie = request.headers['Cookie']
    cookie_list = cookie&.split(';')
    return unless cookie_list

    user_name_cookie = cookie_list.select { |co| co.include?('user_name') }
    return unless user_name_cookie.length.positive?

    user_name_cookie_splitted = user_name_cookie[0].split('=')
    return unless user_name_cookie_splitted.length

    @current_user = user_name_cookie_splitted[1]
  end

  def de_authenticate_user
    response.delete_cookie('user_name')
    # cookies[:user_name] = 'nil' # WORK AROUND FOR COOKIE DELETE PROBLEM
    response.headers['Set-Cookie'] = 'user_name=nil; path=/'
  end

  def request_user_id
    return unless @current_user

    User.where({ user_name: @current_user })[0]&.id
  end
end
