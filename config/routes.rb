Rails.application.routes.draw do
  api_route = '/api'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users,
              controllers: {
                  sessions: 'users/sessions',
                  registrations: 'users/registrations'
              }

  namespace :api do
    # post '/users', to: 'users#create'
    # post '/auth', to: 'users#authenticate'
    # delete '/auth', to: 'users#logout'
    resources :doctors, only: [:index, :show]
  end

  resources :appointments, path: "#{api_route}/appointments"

  # root to: 'home#index'
  get '/test/login', to: 'api/users#test_login'
end
