require 'swagger_helper'

RSpec.describe 'DOCTOR APPOINTMENTS API', type: :request do
  access_token = nil
  let(:Authorization) { "Bearer #{access_token}" }
  first_user = User.where(email: 'fake_user@fake.com')[0]
  second_user = User.all[1]

  path '/api/users/sign_in' do
    post 'Logs in user' do
      tags 'User'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: %w[user email password]
      }

      response '401', 'user cant\'t log in with wrong credentials' do
        let(:credentials) { { user: { email: 'fake_user@fake.com', password: '123456' } } }
        run_test! do |res|
          expect(res.body).to eq({ error: 'Invalid Email or password.' }.to_json)
        end
      end

      response '200', 'user logged in' do
        let(:credentials) { { user: { email: 'fake_user@fake.com', password: 'aa123456' } } }
        run_test! do |res|
          access_token = res.headers['Authorization'].split('Bearer ')[1]
          expect(res.body).to eq({ success: 'Logged in.' }.to_json)
        end
      end
    end
  end

  path '/api/appointments' do
    post 'Creates an appointment' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :appointment, in: :body, schema: {
        type: :object,
        properties: {
          doctor_id: { type: :integer },
          date: { type: :date }
        },
        required: %w[doctor_id date]
      }

      response '201', 'appointment created' do
        doctor = Doctor.all[0]
        let(:appointment) { { doctor_id: doctor&.id, date: DateTime.now } }
        run_test! do |res|
          expect(res.body).to eq({ success: 'Appointment created.' }.to_json)
        end
      end

      response '422', 'invalid request with empty fields' do
        let(:appointment) { {} }
        run_test! do |res|
          expect(res.body).to eq({ error: 'There was an error.' }.to_json)
        end
      end

      response '422', 'invalid request with wrong doctor field' do
        let('Cookie') { "username=#{first_user&.username}" }
        let(:appointment) { { doctor_id: 'FAKE_ID', date: DateTime.now } }
        run_test! do |res|
          expect(res.body).to eq({ error: 'There was an error.' }.to_json)
        end
      end

      response '500', 'invalid request with wrong date format' do
        let('Cookie') { "username=#{first_user&.username}" }
        let(:appointment) { { doctor_id: Doctor.all[0].id, date: 'FAKE_DATE' } }
        run_test! do |res|
          expect(res.body).to eq({ error: appointment_error(:invalid_date) }.to_json)
        end
      end
    end
  end

  path '/api/appointments' do
    get 'Retrieves all appointments of the user' do
      tags 'Appointment'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'appointments retrieved' do
        Appointment.create(user_id: 4, doctor_id: 1, date: DateTime.now)
        run_test! do |res|
          expect(JSON.parse(res.body)[0].keys).to eq(%w[id user_id doctor_id date created_at
                                                        updated_at doctor])
        end
      end

      response '401', 'user not logged in' do
        let(:Authorization) { nil }
        run_test! do |res|
          expect(res.body).to eq({ error: 'You need to sign in or sign up before continuing.' }.to_json)
        end
      end
    end
  end

  path '/api/appointments/{id}' do
    get 'Retrieves an appointment' do
      tags 'Appointment'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'appointment found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 doctor_id: { type: :integer },
                 date: { type: :date },
                 created_at: { type: :date },
                 updated_at: { type: :date }
               },
               required: %w[id user_id doctor_id]

        appointments = Appointment.where({ user_id: first_user.id })
        # p 'APPOINTMENT ID = ', appointments[0].id
        let(:id) { appointments[0].id }
        let(:Authorization) { "Bearer #{access_token}" }
        p access_token, 'HI TOKEN'
        run_test! do |res|
          expect(res.body).to eq(appointments[0].to_json)
        end
      end

      response '404', 'appointment not found' do
        let(:id) { 'FAKE_NUMBER' }
        run_test! do |res|
          expect(res.body).to eq({ error: appointment_error(:show) }.to_json)
        end
      end
    end
  end

  # # EDIT APPOINTMENT

  path '/api/appointments/{id}' do
    appointments = Appointment.where({ user_id: first_user.id })
    let(:id) { appointments[0].id }
    put 'Edits an appointment' do
      tags 'Appointment'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :appointment, in: :body, schema: {
        type: :object,
        properties: {
          doctor_id: { type: :integer },
          date: { type: :date }
        },
        required: %w[doctor_id date]
      }

      response '200', 'appointment edited' do
        appointments = Appointment.where({ user_id: first_user.id })
        let(:id) { appointments[0].id }
        doctor = Doctor.all[0]
        let(:appointment) { { doctor_id: doctor&.id, date: DateTime.now } }
        run_test! do |res|
          expect(JSON.parse(res.body).keys).to include('id', 'doctor_id', 'date', 'user_id')
        end
      end

      response '422', 'invalid request with wrong doctor field' do
        let(:appointment) { { doctor_id: 'FAKE_ID' } }
        run_test! do |res|
          expect(res.body).to eq({ error: { doctor: ['must exist'] } }.to_json)
        end
      end

      response '500', 'invalid request with wrong date field' do
        let(:appointment) { { date: 'FAKE_DATE' } }
        run_test! do |res|
          expect(res.body).to eq({ error: appointment_error(:invalid_date) }.to_json)
        end
      end
    end
  end

  path '/api/appointments/{id}' do
    appointments = Appointment.where({ user_id: second_user.id })
    let(:id) { appointments[0].id }
    put 'Edits the appointment' do
      tags 'Appointment'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :appointment, in: :body, schema: {
        type: :object,
        properties: {
          doctor_id: { type: :integer },
          date: { type: :date }
        },
        required: %w[doctor_id date]
      }

      response '405', 'user is not allowed to update other users\'s appointment' do
        doctor = Doctor.all[0]
        let(:appointment) { { doctor_id: doctor&.id, date: DateTime.now } }
        run_test! do |res|
          expect(res.body).to eq({ error: appointment_error(:update_now_allowed) }.to_json)
        end
      end
    end
  end

  path '/api/appointments/{id}' do
    appointments = Appointment.where({ user_id: first_user&.id })
    let(:id) { appointments[0].id }
    delete 'Deletes the appointment' do
      tags 'Appointment'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'appointment deleted' do
        let(:appointment) { { doctor_id: doctor&.id, date: DateTime.now } }
        run_test! do |res|
          expect(res.body).to eq({ success: appointment_success(:deleted) }.to_json)
        end
      end
    end
  end

  path '/api/appointments/{id}' do
    appointments = Appointment.where({ user_id: second_user&.id })
    let(:id) { appointments[0].id }
    delete 'Deletes the appointment' do
      tags 'Appointment'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      response '405', 'user is not allowed to delete other users\'s appointment' do
        run_test! do |res|
          expect(res.body).to eq({ error: appointment_error(:delete_not_allowed) }.to_json)
        end
      end
    end
  end
end
