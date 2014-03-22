class SessionsController < ApplicationController
  def new
    unless current_user.nil?
      #redirect_to root_path
    end
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user

      redirect_path = root_url
      if not session[:return_to].nil?
        redirect_path = session[:return_to]
      end
      if not session[:activate_email].nil?
        redirect_path = user_activate_path
      end
      redirect_to redirect_path
      session[:user_id] = user.id
    else
      flash.now[:danger] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
