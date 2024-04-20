Rails.application.routes.draw do
  root "home#index"
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  
  resources :posts
  
  resources :profile, only: [:show, :edit, :update, :destroy]
  
  # Custom routes for profile search
  get 'search', to: "search#search"
  post 'search', to: "search#query" 
  # get 'profile/users/search', to: 'profile#search', as: 'profile_search'
  # post 'profile/users/search', to: 'profile#query'


  get "up" => "rails/health#show", as: :rails_health_check
end
