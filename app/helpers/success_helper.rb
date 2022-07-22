module SuccessHelper
  def appointment_success(key)
    messages = {
      deleted: 'Appointment deleted successfully.',
      created: 'Appointment created.',
    }
    messages[key]
  end
end
