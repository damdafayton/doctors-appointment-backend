require 'rails_helper'

# Write the tests for doctor controller

RSpec.describe '/doctors', type: :request do
  # Test for GET /doctors
  describe 'GET /doctors' do
    it 'should return all doctors' do
      get '/api/doctors'
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(Doctor.all.size)
    end
  end

  # Test for GET /doctors/:id
  describe 'GET /doctors/:id' do
    before do
      Doctor.create(
        name: 'Doc Mike',
        speciality: 'Cardiologist',
        price: 1000,
        photo: 'Sample image',
        bio: 'famous on youtube'
      )
    end
    it 'should return a doctor' do
      get "/api/doctors/#{Doctor.first.id}"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['id']).to eq(Doctor.first.id)
    end
  end
end
