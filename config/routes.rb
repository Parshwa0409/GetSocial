Rails.application.routes.draw do
  get 'activities/index'
  root "home#index"

  # mount ActionCable.server => "/"
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  
  resources :posts do 
    post 'share/:user_id', to: 'posts#share', as: 'share_post'
    resources :comments, only: [ :index, :create ]
  end
  
  resources :profile, only: [:show, :edit, :update, :destroy]
  
  # Custom Routes for Requests Handling
  get 'follow_requests', to: 'requests#follow_requests'
  get 'pending_requests', to: 'requests#pending_requests'
  get 'blocked_users', to: "requests#blocked_users"

  post 'requests/:id/follow', to: "requests#follow", as: "follow"
  post 'requests/:id/unfollow', to: "requests#unfollow", as: "unfollow"
  post 'requests/:id/accept', to: "requests#accept", as: "accept"
  post 'requests/:id/decline', to: "requests#decline", as: "decline"
  post 'requests/:id/cancel', to: "requests#cancel", as: "cancel"
  post 'requests/:id/block', to: "requests#block", as: "block"
  post 'requests/:id/unblock', to: "requests#unblock", as: "unblock"

  # Custom routes for profile search
  get 'search', to: "search#search"
  post 'search', to: "search#query" 

  # Likes Routes
  resources :likes, only: [:create, :destroy]

  # Activities Routes
  resources :activities, only: [:index]

  # Messsages Routes
  resources :messages, only: [:index, :create, :show]

  # Notification Management
  post "notifications/mark_all_pan_as_read", to: "notifications#mark_all_pan_as_read"
  post "notifications/mark_all_dm_as_read", to: "notifications#mark_all_dm_as_read"

  # Notification Preferences
  resources :notification_preferences, only: [:create, :destroy]

  # Story & Views
  resources :stories, only: [:create, :index, :show] do 
    collection do 
      get "my_stories"
    end
  end
  resources :story_views, only: [:create]

  get "up" => "rails/health#show", as: :rails_health_check
end
