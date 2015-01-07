Rails.application.routes.draw do
  devise_for :users
  resources :prototypes 
  resources :comments
  resources :users, :only => [:show]
  get 'users/show'

  authenticated :user do
    root to: "prototypes#index", :as => "authenticated_root"
  end
  root to: "prototypes#index"

  get '/prototype/:id/like', to: 'prototypes#like'
  get '/prototype/:id/unlike', to: 'prototypes#unlike'
  get '/comment/create/:id', to: 'prototypes#like'

  get '/users', to: 'prototypes#index'
  get '/users/:id/follow', to: 'users#follow'
  get '/users/:id/unfollow', to: 'users#unfollow'
  get '/users/:id/followers', to: 'users#followers'

  get '/notifications', to: 'notifications#index'
  get '/p/:id', to: 'prototypes#show'

  # get "/pages/*id" => 'pages#show', as: :page, format: false
end