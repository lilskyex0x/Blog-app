Rails.application.routes.draw do
  # Routes for users
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show', as: 'user'

  # Routes for posts
  get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'

  get "up" => "rails/health#show", as: :rails_health_check
end
