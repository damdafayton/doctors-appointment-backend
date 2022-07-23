class DoctorsController < ApplicationController
  # before_action :authenticate_user!

  def index
    p current_user&.username, 'HELLO DOCTORS INDEX'
    p request.headers[:Authorization]
    p request.headers['Authorization']

    @doctors = Doctor.all
    render json: @doctors
  end

  def show
    @doctor = Doctor.find(params[:id])
    render json: @doctor
  end
end
