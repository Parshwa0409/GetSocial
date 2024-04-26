Rails.application.routes.draw do
  get 'activities/index'
  root "home#index"
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  
  resources :posts do 
    resources :comments, only: [ :index, :create]
  end
  
  resources :profile, only: [:show, :edit, :update, :destroy]
  
  # Custom Routes for Requests Handling
  get 'follow_requests', to: 'requests#follow_requests'
  get 'pending_requests', to: 'requests#pending_requests'
  post 'requests/:id/follow', to: "requests#follow", as: "follow"
  post 'requests/:id/unfollow', to: "requests#unfollow", as: "unfollow"
  post 'requests/:id/accept', to: "requests#accept", as: "accept"
  post 'requests/:id/decline', to: "requests#decline", as: "decline"
  post 'requests/:id/cancel', to: "requests#cancel", as: "cancel"

  # Custom routes for profile search
  get 'search', to: "search#search"
  post 'search', to: "search#query" 

  # Likes Routes
  resources :likes, only: [:create, :destroy]

  # Activities Routes
  resources :activities, only: [:index]

  get "up" => "rails/health#show", as: :rails_health_check
end
