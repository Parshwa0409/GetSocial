Rails.application.routes.draw do
  
  root "home#index"
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 

  resources :posts

  resources :profile, only: [:show, :edit]
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
