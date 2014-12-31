Rails.application.routes.draw do
  resources :prototypes
  devise_for :users #, :controllers => { :omniauth_callbacks => "callbacks" }

  authenticated :user do
    root to: "prototypes#index", :as => "authenticated_root"
  end
  root to: 'high_voltage/pages#show', id: 'index'

  # get '/auth/:provider/callback' => 'sessions#create'
  # get '/signin' => 'sessions#new', :as => :signin
  # get '/signout' => 'sessions#destroy', :as => :signout
  # get '/auth/failure' => 'sessions#failure'
end
