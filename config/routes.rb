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

  post "/api/v1/slack/interactive-messages/callback", to: 'api/v1/slack/interactive_messages#create' # TODO: 別の書き方があると思うので後ほど調べる
end
