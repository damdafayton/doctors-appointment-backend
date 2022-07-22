require 'swagger_helper'
require 'rails_helper'

# Write tests for the user API here.
RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema:
      {
        type: :object,
        properties: {
          user_name: { type: :string },
          email: { type: :string }
        },
        required: %w[user_name email]
      }

      response '201', 'User created successfully' do
        let(:user) { { user_name: 'aquaman', email: 'aquaman@gmail.com' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { user_name: 'birdman' } }
        run_test!
      end
    end
  end
  path '/api/auth' do
    post 'Login for user' do
      tags 'Users'
      consumes 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user_name: { type: :string }
        },
        required: ['user_name']
      }
      response '200', 'User logged in successfully' do
        let(:user) { { user_name: 'bobbob' } }
        run_test!
      end

      response '404', 'Not found' do
        let(:user) { { user_name: 'bully2' } }
        run_test!
      end
    end
  end
end
