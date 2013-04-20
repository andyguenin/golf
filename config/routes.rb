Spool::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  root :to => "pages#index"
  get "about" => "pages#about"
  resources :users, :except => :index
  resources :sessions
  resources :golf
  resources :groups
  resources :tournaments
  resources :pools, :except => :index
end
