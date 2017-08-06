Rails.application.routes.draw do
  get 'messages/create'
  resources :sessions, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
