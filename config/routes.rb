require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  root 'messages#index'
  resources :messages, only: [:index, :new]
  resources :sessions, only: [:index]

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :messages, only: [:index, :show, :create]
      namespace :slack do
        resources :users, only: [:index]
      end
    end
  end
end
