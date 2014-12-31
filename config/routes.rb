Rails.application.routes.draw do
  resources :prototypes

  devise_for :users

  authenticated :user do
    root to: "prototypes#index", :as => "authenticated_root"
  end
  root to: 'visitors#index'
end
