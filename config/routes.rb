Rails.application.routes.draw do
  get 'users/show'

  devise_for :users
  resources :prototypes
  resources :users, :only => [:show]

  authenticated :user do
    root to: "prototypes#index", :as => "authenticated_root"
  end
  root to: 'high_voltage/pages#show', id: 'about'

  get '/prototype/:id/like', to: 'prototypes#like'
  get '/prototype/:id/unlike', to: 'prototypes#unlike'

end
