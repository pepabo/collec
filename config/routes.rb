Rails.application.routes.draw do
  get 'messages/index'
  get 'messages/create'
  resources :sessions, only: [:index]

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :messages, only: :index
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
