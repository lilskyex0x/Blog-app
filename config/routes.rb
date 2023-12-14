Rails.application.routes.draw do
  # Devise routes with custom path names
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  # Root route for authenticated users
  authenticated :user do
    root 'users#index', as: :authenticated_root
  end

  # Root route for unauthenticated users
  devise_scope :user do
    unauthenticated :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  # User routes
  get '/users', to: 'users#index', as: 'users'
  get '/users/:id', to: 'users#show', as: 'user'

  # Post routes
  get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
  post '/users/:user_id/posts', to: 'posts#create', as: 'create_user_post'

  # Comment routes
  get '/posts/:post_id/comments', to: 'comments#index', as: 'post_comments'
  get '/posts/:post_id/comments/:id', to: 'comments#show', as: 'post_comment'
  post '/posts/:post_id/comments', to: 'comments#create', as: 'create_post_comment'

  # Like routes
  post '/posts/:post_id/likes', to: 'likes#create', as: 'create_post_like'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
