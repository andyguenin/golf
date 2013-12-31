Spool::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  root :to => "tournaments#current"
  get "about" => "pages#about"


  resources :tournaments
  get "tournaments/:id/:player" => "tournaments#player", :as => "t_player"

  resources :users, :except => :index
  resources :sessions
  resources :players, :except => :index
  

  
  resources :pools do
    resources :picks
  end
  get "pool/:id/publish" => "pools#publish", :as => "publish_pool"
  get "pool/:id/unpublish" => "pools#unpublish", :as => "unpublish_pool"
  get "pool/:id/join" => "pools#join", :as => "join_pool"
  get "pool/:id/leave" => "pools#leave", :as => "leave_pool"
  match "pool/:id/invite" => "pools#invite", :as => "invite_pool", :via => [:get, :post]
  
  get "score" => "api#insert_score"
  post "insert" => "api#is"
end
