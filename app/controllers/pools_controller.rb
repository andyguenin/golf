class PoolsController < ApplicationController
  helper_method :get_pools_attributes

  before_filter :getAvailableTournaments, :only => [:new, :create, :update, :edit]
  
  def getAvailableTournaments
    Tournament.where("starttime > ?", Time.now)
  end
  
  def admins
    @pool = Pool.find(params[:id])
    authorize! :manage, @pool
  end

  def mypicks
    @pool = Pool.find(params[:id])
    authorize! :read, @pool

    puts can? :read, @pool
    sleep(5.0)
    @picks = current_user.picks.where("pool_id = ?", Pool.last.id)
    @questions = @pool.q_answers.order("number asc")
    render 'summary'
  end
  
  def admins_update
    @pool = Pool.find(params[:id])
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
    @pool = Pool.find(params[:id])
    authorize! :update, @pool
    @pool.update_attribute(:published, true)
    PoolMembership.create({:user_id => current_user.id, :pool_id => @pool.id, :active => true}) unless @pool.users.include? current_user
    redirect_to pool_path(@pool)
  end

  def unpublish
    @pool = Pool.find(params[:id])
    authorize! :unpublish, @pool
    @pool.update_attribute(:published, false)
    redirect_to pool_path(@pool)
  end
  
  def invite
    @pool = Pool.find(params[:id])
    authorize! :invite, @pool
    @emails = params[:emails] ? params[:emails].split("\n").join(" ").split("\r").join(" ").scan(/([a-zA-Z]\S*@[a-zA-Z0-9\.-]*)/).map {|t| t[0]}.uniq : []
    if(params[:confirm] && params[:confirm] == "true")
      characters = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
      @emails.each do |e|
        #if email already exists for a user, create an inactive user/pool association
        u = User.create({:active => false, :email => e})
        unless(u)
          u = User.find_by_email(e)
        else
          a = NonmemberInvitee.create!({:inviter_id => current_user.id, :user_id => u.id, :pool_id => @pool.id, :activation_key => (0..58).map{characters.sample}.join})
        end
        pm = PoolMembership.create!({:user_id => u.id, :pool_id => @pool.id, :active => false, :inviter_id => current_user.id})
      end
      redirect_to @pool
    end     
  end
  
  def join
    @pool = Pool.find(params[:id])
    authorize! :join, @pool
    pm = PoolMembership.where("user_id = ? and pool_id = ?", current_user.id, @pool.id)[0]
    if pm.nil?
      pm = PoolMembership.new({:user_id => current_user.id, :pool_id => @pool.id, :active => true})
      unless(pm.save)
        redirect_to @pool, :error => "There is an error: please contact #{email}"
      else
       redirect_to @pool, :success => "You have joined the pool!"
      end
    else
      pm.update_attribute(:active, true)
     redirect_to @pool, :notice => "You have joined the pool!"
    end
  end
  
  def leave
    @pool = Pool.find(params[:id])
    authorize! :leave, @pool
    pm = PoolMembership.where("user_id = ? and pool_id = ?", current_user.id, @pool.id)[0]
    pm.destroy
    redirect_to pools_path
  end
  
  
  def index
    @pools = Pool.all.each.select {|po| can? :read, po}
  end

  def show
    @pool = Pool.find(params[:id], :include => [:tournament, :q_answers])
    authorize! :read, @pool
    @questions = @pool.q_answers.order("number asc")
    if can? :read, @pool and @pool.tournament.locked
      @picks = @pool.picks.order("score asc, #{ "ABS(picks.tiebreak - " + @pool.tournament.low_score.to_s + ") asc," if @pool.tournament.low_score} id asc")
    else
      @picks = current_user.picks.where("pool_id = ?", Pool.last.id)
      render 'summary'
    end
  end  

  def new
    @pool = Pool.new
    @tournament_options = getAvailableTournaments
    authorize! :create, @pool
  end
  
  def create
    questions = ["q1","q2","q3","q4","q5"]
    @pool = Pool.new(params[:pool].except(*questions))
    @pool.nonadmin_invite = true
    authorize! :create, @pool
    @tournament_options = getAvailableTournaments
    @pool.tournament = Tournament.find(params[:pool]["tournament_id"]) 
    if(@pool.save)
      @pool.update_attributes(params[:pool].slice(*questions))
      @pool.admin_members.create!({:user => current_user, :creator => true, :active => true})
      redirect_to @pool
    else
      render 'new'
    end
  end
  
  def edit
    @pool = Pool.find(params[:id])
    @tournament_options = getAvailableTournaments
    authorize! :update, @pool
  end

  def update
    @pool = Pool.find(params[:id])
    authorize! :update, @pool
    @tournament_options = getAvailableTournaments
    if(@pool.update_attributes(params[:pool]))
      redirect_to @pool
    else
      render 'edit'
    end
  end


  def getAvailableTournaments
    Tournament.where("starttime > ?", Time.now)
    Tournament.all
  end
  




end
