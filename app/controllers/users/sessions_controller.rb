class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def check
    p 'SESSION CHECK'
    render json: { user: current_user }, status: :ok
  end

  private

  def respond_with(_resource, _opts = {})
    if current_user
      p current_user, 'HELLO LOGGED IN :)'
      render json: { success: 'Logged in.' }, status: :ok
    else
      p current_user, 'HELLO LOG IN ERROR!!'
      render json: { error: 'Please log in.' }, status: 402
    end
  end

  def respond_to_on_destroy
    p current_user, 'HELLO LOGOUT CHECKER!!'
    if current_user.nil?
      log_out_success
    else
      log_out_failure
    end
  end

  def log_out_success
    render json: { success: 'Logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { error: 'Log out failure.' }, status: :unauthorized
  end
end
