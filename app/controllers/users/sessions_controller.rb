class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    if current_user
      p current_user, 'HELLO LOGGED IN :)'
      render json: { message: 'Logged.' }, status: :ok
    else
      p current_user, 'HELLO LOG IN ERROR!!'
      render json: { message: 'Please log in.' }, status: 402
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
    render json: { message: 'Logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Logged out failure.' }, status: :unauthorized
  end
end
