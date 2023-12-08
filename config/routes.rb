Rails.application.routes.draw do
  root 'users#index'
  # Routes for users
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show', as: 'user'

  # Routes for posts
  get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
  post '/users/:user_id/posts', to: 'posts#create'

  resources :posts do
    resources :comments
    resources :likes, only: [:create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
  
end
