Rails.application.routes.draw do
  # devise_for :users
  api_route = '/api'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users, path: "#{api_route}/users",
              controllers: {
                  sessions: 'users/sessions',
                  registrations: 'users/registrations'
              }

  # namespace :api do
  #   # post '/users', to: 'users#create'
  #   # post '/auth', to: 'users#authenticate'
  #   # delete '/auth', to: 'users#logout'
  # end
  resources :doctors, path: "#{api_route}/doctors", only: [:index, :show]
  resources :appointments, path: "#{api_route}/appointments"

  # root to: 'home#index'
  get '/test/login', to: 'api/users#test_login'
end
