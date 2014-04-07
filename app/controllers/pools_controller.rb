class PoolsController < ApplicationController
  helper_method :get_pools_attributes

  before_filter :getAvailableTournaments, :only => [:new, :create, :update, :edit]
  
  def getAvailableTournaments
    Tournament.where("starttime > ?", Time.now)
  end
  
  def admins
    @pool = Pool.find_by_slug(params[:id])
    authorize! :manage, @pool
  end

  def userpicks
    @pool = Pool.find_by_slug(params[:pool_id])
    @user = User.find_by_username(params[:id])
    pm = @user.pool_memberships.where("pool_id = ?", (@pool.id))
    if pm.empty?
      @picks = []
      render 'single_user'
    else
      authorize! :view_user_picks, pm[0]
      @picks = @user.get_picks_by_tournament(@pool.tournament)
      render 'single_user'
    end
  end
  
  def admins_update
    @pool = Pool.find_by_slug(params[:id])
    authorize! :manage, @pool
    admins = params[:pool_member]
    @pool.pool_memberships.each do |pm|
      if not admins.nil? and admins[pm.id.to_s] == "1" or pm.user == current_user
        pm.update_attribute(:admin, true)
      else
        pm.update_attribute(:admin, false)
      end
    end
    redirect_to edit_pool_path @pool
  end
  
  def publish
    @pool = Pool.find_by_slug(params[:id])
    authorize! :update, @pool
    @pool.update_attribute(:published, true)
    PoolMembership.create({:user_id => current_user.id, :pool_id => @pool.id, :active => true}) unless @pool.users.include? current_user
    redirect_to pool_path(@pool)
  end

  def unpublish
    @pool = Pool.find_by_slug(params[:id])
    authorize! :unpublish, @pool
    @pool.update_attribute(:published, false)
    redirect_to pool_path(@pool)
  end
  
  def invite
    @pool = Pool.find_by_slug(params[:id])
    authorize! :invite, @pool
    new_users = 0
    existing_users = 0
    already_users = 0
    @emails = params[:emails] ? params[:emails].split("\n").join(" ").split("\r").join(" ").scan(/([a-zA-Z]\S*@[a-zA-Z0-9\.-]*)/).map {|t| t[0]}.uniq : []
    @message = params[:message]
    if(params[:confirm] && params[:confirm] == "true")
      characters = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
      @emails.each do |e|
        #if email already exists for a user, create an inactive user/pool association
        u = User.create({:active => false, :email => e})
        t_exist = false
        if u.id.nil?
          u = User.find_by_email(e)
          t_exist = true
        else
          invite = NonmemberInvitee.create!({:inviter_id => current_user.id, :user_id => u.id, :pool_id => @pool.id, :activation_key => (0..58).map{characters.sample}.join})
          UserMailer.invite(u, invite, @message).deliver
          new_users += 1
        end
        already_users += 1
        unless u.all_pools.include? @pool
          pm = PoolMembership.new({:user_id => u.id, :pool_id => @pool.id, :active => false, :inviter_id => current_user.id})
          already_users -= 1
          existing_users += 1 if t_exist
        end
      end
      redirect_to @pool, :flash => {:success => "#{new_users} new users and #{existing_users} existing users invited to pool, #{already_users} users not invited"}
    end     
  end
  
  def join
    @pool = Pool.find_by_slug(params[:id])
    authorize! :join, @pool
    if current_user.nil?
      session[:return_to] = pool_path(@pool)
      redirect_to login_path, :flash => {:warning => "You must be signed in to join a pool."}
    else
      @pool.user_join(current_user)
      redirect_to pool_path @pool
    end
  end
  
  def leave
    @pool = Pool.find_by_slug(params[:id])
    authorize! :leave, @pool
    pm = PoolMembership.where("user_id = ? and pool_id = ?", current_user.id, @pool.id)[0]
    pm.destroy
    redirect_to pools_path
  end
  
  
  def index
    @pools = Pool.all.each.select {|po| can? :read, po}
  end

  def show
    @pool = Pool.find_by_slug(params[:id], :include => :tournament)
    authorize! :read, @pool
    @questions = @pool.q_answers
    if can? :read, @pool
      @picks = @pool.picks.order("score asc, #{ "ABS(picks.tiebreak - " + @pool.tournament.low_score.to_s + ") asc," if @pool.tournament.low_score} id asc")
    else
      @picks = []
    end
  end  

  def new
    @pool = Pool.new
    @tournament_options = getAvailableTournaments
    authorize! :create, @pool
  end
  
  def create
    @pool = Pool.new(params[:pool])
    @pool.nonadmin_invite = true
    authorize! :create, @pool
    @tournament_options = getAvailableTournaments
    @pool.tournament = Tournament.find(params[:pool]["tournament_id"]) 
    if(@pool.save)
      @pool.admin_members.create!({:user => current_user, :creator => true, :active => true})
      redirect_to @pool
    else
      render 'new'
    end
  end
  
  def edit
    @pool = Pool.find_by_slug(params[:id])
    @tournament_options = getAvailableTournaments
    authorize! :update, @pool
  end

  def update
    @pool = Pool.find_by_slug(params[:id])
    authorize! :update, @pool
    @tournament_options = getAvailableTournaments
    if(@pool.update_attributes(params[:pool]))
      redirect_to @pool
    else
      render 'edit'
    end
  end
end
