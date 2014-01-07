class ApplicationController < ActionController::Base
  protect_from_forgery
  
  http_basic_authenticate_with name: "mr. ducky", password: "golf@blackrock" if Rails.env.production? and not params[:controller] == "api_controller"

  helper_method :current_user, :selected_menu, :print_menu_active

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def selected_menu
    case params[:controller]
    when "groups"
      :groups
    when "pools"
      :pools
    when "tournaments"
      :tournament
    when "pages"
      params[:action] == "index" ? :home : :none
    when "picks"
      :pools
    else
      :none
    end
  end

  def print_menu_active(e)
    "class=\"active\"".html_safe if e==selected_menu
  end
  
  def email
    "andyguenin@gmail.com"
  end
end
