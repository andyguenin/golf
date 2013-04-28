Spool::Application.routes.draw do
#  get "testytesttest" => "scores#new"
  #
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
  resources :groups, :only => [:new, :create]
  resources :groups, :path => '', :except => [:new, :create]  do
    resources :pools, :except => [:index]
  end

  resources :players, :except => :index
end
