Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  root 'messages#index'
  resources :messages, only: [:index, :new]
  resources :sessions, only: [:index]
end
