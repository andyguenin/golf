require 'resque/server'
Spool::Application.routes.draw do


  mount Resque::Server.new, at: "/resque"
  post "insert" => "api#is"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "forgot" => "users#forgot_password", :as => "forgot_password"
  get "send_reset" => "users#send_forgotten_password", :as => "send_reset"
  get "signup" => "users#new", :as => "signup"
  root :to => "pages#index"
  get "about" => "pages#about"


  resources :tournaments
  get "tournaments/:id/:player" => "tournaments#player", :as => "t_player"

  get "users/activate" => "users#activate", :as => "user_activate"
  resources :users, :except => :index
  resources :sessions
  resources :players, :except => :index
  resources :scrapers, :except => :show

  get "pools/:id/user/:username" => "pools#userpicks", :as => "user_picks"
  get "pools/:pool_id/picks/:id/approve" => "picks#approve", :as => "approve_pick"
  get "pools/:pool_id/picks/:id/reject" => "picks#reject", :as => "reject_pick"
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
  
  
end
