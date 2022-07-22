require 'pry'

class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ErrorHelper
  include SuccessHelper
  # @current_user = nil # parse request and check username

  # def authenticate_user
  #   return if cookies[:username] == 'nil'

  #   # binding.pry
  #   cookie = request.headers['Cookie']
  #   cookie_list = cookie&.split(';')
  #   return unless cookie_list

  #   username_cookie = cookie_list.select { |co| co.include?('username') }
  #   return unless username_cookie.length.positive?

  #   username_cookie_splitted = username_cookie[0].split('=')
  #   return unless username_cookie_splitted.length

  #   @current_user = username_cookie_splitted[1]
  # end

  # def de_authenticate_user
  #   response.delete_cookie('username')
  #   # cookies[:username] = 'nil' # WORK AROUND FOR COOKIE DELETE PROBLEM
  #   response.headers['Set-Cookie'] = 'username=nil; path=/'
  # end

  # def request_user_id
  #   return unless @current_user

  #   User.where({ username: @current_user })[0]&.id
  # end
end
