module SuccessHelper
  def appointment_success(key)
    messages = {
      deleted: 'Appointment deleted successfully.'
    }
    messages[key]
  end
end
