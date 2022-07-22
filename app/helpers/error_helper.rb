module ErrorHelper
  def appointment_error(type)
    errors = {
      index: 'Please log in to see your appointments.',
      show: 'Appointment can not be found.',
      invalid_date: 'Date format is wrong.',
      update_not_allowed: 'You are not allowed to update this appointment.',
      delete_not_allowed: 'You are not allowed to delete this appointment.',
      unkown: 'There was an error.',
      # missing_param: 'param is missing or the value is empty',
      # wrong_date: 'invalid date'
    }
    errors[type]
  end

  def invalid_date
    render json: { error: appointment_error(:invalid_date) }, status: 500
  end
end
