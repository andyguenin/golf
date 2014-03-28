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
      if not nmi.nil?
        nmi.destroy
      end
      redirect_to login_url, :flash => {:success => "Signed up! Please log in."}
    else
      message = "Please fix the errors below."
      if params[:user][:password] != params[:user][:password_confirmation]
        message = "Passwords do not match. Please enter matching passwords."
      end
      flash.now[:danger] = message
      render "new"
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
        redirect_to signup_path, :flash => {:info => "You must first create an account. You will then be prompted to sign in and then redirected to your pool."}
      else
        if can? :accept, nmi and nmi.pool.user_join(nmi.user)
          redirect_to pool_path(nmi.pool), :flash => {:success => "You have joined the pool. Enter your picks before the tournament starts!"}
        else
          redirect_to root_path, :flash => {:danger => "Pool has been locked or expired. You cannot join."}
        end
        nmi.delete
      end
    end
  end

  def forgot_password
  end

  def send_forgotten_password
    u = User.find_by_username(params[:login])
    if(u.nil?)
      u = User.find_by_email(params[:login])
    end
    characters = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    key = (0..58).map{characters.sample}.join
    unless u.nil?
      u.update_attribute(:forgot_password, key)
      InviteMailer.forgot_password(u).deliver
    end
    f = {:success => "An email has been sent to that user."}
    if not flash[:danger].nil?
      f = {:danger => flash[:danger]}
    end
    redirect_to root_path, :flash => f
  end
        
  private
  def require_logged_out
    if current_user
      redirect_to root_path, :flash => {:alert => "Cannot perform that action while logged in"}
    end
  end
  
    
end
