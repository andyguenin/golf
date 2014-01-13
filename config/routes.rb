Spool::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  root :to => "pages#index"
  get "about" => "pages#about"


  resources :tournaments
  get "tournaments/:id/:player" => "tournaments#player", :as => "t_player"

  get "users/activate" => "users#activate", :as => "user_activate"
  resources :users, :except => :index
  resources :sessions
  resources :players, :except => :index
  

  
  resources :pools do
    resources :picks
  end
  get "pools/:id/publish" => "pools#publish", :as => "publish_pool"
  get "pools/:id/unpublish" => "pools#unpublish", :as => "unpublish_pool"
  get "pools/:id/join" => "pools#join", :as => "join_pool"
  get "pools/:id/leave" => "pools#leave", :as => "leave_pool"
  get "pools/:id/edit/admins" => "pools#admins", :as => "edit_admins_pool"
  put "pools/:id/edit/admins" => "pools#admins_update", :as => "update_admins_pool"
  match "pools/:id/invite" => "pools#invite", :as => "invite_pool", :via => [:get, :post]
  
  get "score" => "api#insert_score"
  
  unless Rails.env.production?
    get "insert_t" => "api#is_test"
  end
  
  post "insert" => "api#is"
end
