Spool::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  root :to => "pages#index"
  get "about" => "pages#about"


  resources :tournaments
  get "tournaments/:id/:player" => "tournaments#player", :as => "t_player"
  resources :users, :except => :index
  resources :sessions
  resources :golf
  resources :players, :except => :index
  resources :pools
  get "score" => "api#insert_score"
  post "insert" => "api#is"
end
