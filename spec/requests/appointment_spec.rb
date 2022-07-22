require 'rails_helper'

RSpec.describe 'Appointments', type: :request do
  describe 'GET /api/appointments' do
    # pending "add some examples (or delete) #{__FILE__}"
    it 'returns nothing if user is not logged in' do
      get appointments_url
      expect(response.body).to eq({ error: appointment_error(:index) }.to_json)
    end
  end
end
