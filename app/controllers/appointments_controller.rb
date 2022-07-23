require 'pry'

class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: %i[show update destroy]
  rescue_from Date::Error, with: :invalid_date

  def index
    # binding.pry
    p current_user.username, 'HELLO APPOINTMENTS INDEX'
    if current_user
      user = User.where({ username: current_user.username })
      @appointments = Appointment.where({ user_id: user[0]&.id }).includes(:doctor).to_json(include: :doctor)

      render json: @appointments, status: :ok
    else
      render json: { error: appointment_error(:index) }, status: 422
    end
  end

  # GET /appointments/1
  def show
    render json: @appointment
  end

  # POST /appointments
  def create
    params[:appointment][:user_id] = current_user&.id
    # p 'CREATE APPO', current_user
    params[:appointment][:date] = params[:appointment][:date]&.to_datetime

    # p params[:appointment]
    @appointment = Appointment.new(params_permit)

    if @appointment.save
      # render json: @appointment, status: :created, location: @appointment
      render json: { success: appointment_success(:created) }, status: 201
    else
      render json: { error: appointment_error(:unkown) }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    unless request_user_owns_the_appointment?
      render json: { error: appointment_error(:update_now_allowed) }, status: 405
      return
    end

    # Inject correct params
    params[:user_id] = current_user.id
    params[:date] = params[:date].to_datetime if params[:date]

    if @appointment.update(params_permit)
      render json: @appointment
    else
      render json: { error: @appointment.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    unless request_user_owns_the_appointment?
      render json: { error: appointment_error(:delete_not_allowed) }, status: 405
      return
    end

    @appointment.destroy
    render json: { success: appointment_success(:deleted) }, status: 200
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: appointment_error(:show) }, status: 404
  end

  # Only allow a list of trusted parameters through.
  def params_permit
    p 'APPOINTMENT PARAM CHECK'
    params.require(:appointment).permit(:doctor_id, :date, :user_id)
  end

  def request_user_owns_the_appointment?
    appointment_user_id = Appointment.where({ id: params[:id] })[0]&.user_id
    current_user.id == appointment_user_id
  end
end
