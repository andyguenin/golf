class ApplicationController < ActionController::Base
  protect_from_forgery

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
  
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end
 
  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end
end
