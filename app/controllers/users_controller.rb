class UsersController < ApplicationController
  
  before_filter :require_logged_out, :only => [:new, :create, :forgot_password, :send_forgotten_password]
  
  def new
    @user = session[:activate_email].nil? ? User.new : User.find_by_email(session[:activate_email])
  end

  def create
    @user = nil
    nmi = nil
    if not session[:activate_email].nil?
      nmis = NonmemberInvitee.includes(:user).where("users.email = ? and activation_key = ?", session[:activate_email], session[:activate_activation])
      if nmis.empty?
        redirect_to root_path, :flash => {:danger => "There is no invite corresponding to that email address and activation code"}
        return false
      end
      nmi = nmis[0]
      @user = nmi.user
      @user.assign_attributes(params[:user].merge({:active => true}))
    else
      @user = User.new(params[:user].merge({:active => true}))
    end
    if @user.save
      if not session[:activate_email].nil? and  params[:user][:email] != session[:activate_email] 
        session[:activate_email] = params[:user][:email]
      end
      session[:user_id] = @user.id
      redirect_to user_activate_path
    else
      message = "Please fix the errors below."
      if params[:user][:password] != params[:user][:password_confirmation]
        message = "Passwords do not match. Please enter matching passwords."
      end
      flash.now[:danger] = message
      render "new"
    end
  end
  
  def edit
    @user = User.find_by_username(params[:id])
    authorize! :edit, @user
  end
  
  def update
    @user = User.find_by_username(params[:id])
    authorize! :edit, @user
    if @user.update_attributes(params[:user])
      redirect_to root_path, flash: {success: "Updated!"}
    else
      render 'edit'
    end    
  end
  
  def activate
    email = params[:email] || session[:activate_email]
    code = params[:activation] || session[:activate_activation]
    nmis = NonmemberInvitee.includes(:user).where("users.email = ? and activation_key = ?", email, code)
    if nmis.size == 0
      redirect_to root_path, :flash => {:danger => "There is no invite corresponding to that email address and activation code"}
      reset_session
    else
      nmi = nmis.first
      if not nmi.user.active
        session[:activate_email] = email
        session[:activate_activation] = code
        redirect_to signup_path, :flash => {:info => "You must first create an account. You will then be redirected to your pool."}
      else
        if can? :accept, nmi and nmi.pool.user_join(nmi.user)
          redirect_to pool_path(nmi.pool), :flash => {:success => "You have joined the pool. Enter your picks before the tournament starts!"}
        else
          redirect_to root_path, :flash => {:danger => "Pool has been locked or expired. You cannot join."}
        end
        uid = session[:user_id]
        reset_session
        session[:user_id] = uid
        nmi.pool.user_join(nmi.user)
        puts nmi.user
        puts nmi.user.name
        nmi.destroy
      end
    end
  end
  
  def forgot_password
  end

  def send_forgotten_password
    u = User.find_by_username(params[:login]) || User.find_by_email(params[:login])
    characters = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    key = (0..58).map{characters.sample}.join
    unless u.nil?
      u.update_attribute(:forgot_password, key)
      UserMailer.forgot_password(u).deliver
    end
    f = {:success => "An email has been sent to that user."}
    if not flash[:danger].nil?
      f = {:danger => flash[:danger]}
    end
    redirect_to root_path, :flash => f
  end
  
  def reset
    @user = User.find_by_username(params[:username])
    unless @user.nil?
      unless @user.forgot_password == params[:key]
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
  
  def fix_password
    @user = User.find_by_username(params[:username])
    unless @user.nil?
      if @user.forgot_password == params[:key]
        if @user.reset_password({:password => params[:password], :password_confirmation => params[:password_confirmation]})
          redirect_to login_path, flash: {success: "Your password has successfully been reset. Please sign in!"}
        else
          @user.reload
          render 'reset'
        end        
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
        
  private
  def require_logged_out
    if current_user
      redirect_to root_path, :flash => {:alert => "Cannot perform that action while logged in"}
    end
  end
  
    
end
