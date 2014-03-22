class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_path = root_url
      if not session[:return_to].nil?
        redirect_path = session[:return_to]
      end
      redirect_to redirect_path
      session.delete(:return_to)
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
