require 'swagger_helper'
require 'rails_helper'

RSpec.describe '/api/doctors', type: :request do
  path '/api/doctors' do
    get 'Retrieves all doctors' do
      tags 'Doctors'
      produces 'application/json'

      response '200', 'list of doctors' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   name: { type: :string },
                   speciality: { type: :string },
                   image: { type: :string },
                   price: { type: :number },
                   bio: { type: :string },
                   created_at: { format: 'date-time' },
                   updated_at: { format: 'date-time' }
                 }
               }
        run_test!
      end
    end
  end
  path '/api/doctors/{id}' do
    get 'Fetches a doctor' do
      tags 'Doctors'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, required: true
      response '200', 'a single doctor' do
        schema type: :object,
               properties: {
                 name: { type: :string },
                 speciality: { type: :string },
                 photo: { type: :string },
                 price: { type: :number },
                 bio: { type: :string },
                 created_at: { format: 'date-time' },
                 updated_at: { format: 'date-time' }
               }
        let(:id) do
          Doctor.create(
            name: 'Doc Mike',
            speciality: 'Cardiologist',
            price: 1000,
            photo: 'Sample image',
            bio: 'famous on youtube'
          ).id
        end
        run_test!
      end
    end
  end
end
