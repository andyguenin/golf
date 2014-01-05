class UsersController < ApplicationController
  
  before_filter :require_logged_out
  
  def new
    @user = User.new
  end

  def create
    @user = nil
    if params[:email].nil? and params[:activation].nil?
      @user = User.new(params[:user].merge({:active => true}))
    else
      u = NonmemberInvitee.includes(:user).where("users.email = ? and activation_key = ?", params[:email], params[:activation])[0]
      if u.nil?
        redirect_to root_path
      end
      @user = u.user
      @user.update_attributes(params[:user].merge({:active => true}))
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
  def activate
    u = NonmemberInvitee.includes(:user).where("users.email = ? and activation_key = ?", params[:email], params[:activation])[0]
    if u.nil?
      redirect_to root_path
    else
      @user = u.user
      render "new"
    end
  end
        
  private
  def require_logged_out
    if current_user
      redirect_to root_path, :alert => "Cannot perform that action while logged in"
    end
  end
  
    
end
