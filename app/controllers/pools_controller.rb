class PoolsController < ApplicationController
  helper_method :get_pools_attributes

  before_filter :getAvailableTournaments, :only => [:new, :create, :update, :edit]
  
  def getAvailableTournaments
    Tournament.where("starttime > ?", Time.now)
  end

  def publish
    @pool = Pool.find(params[:id])
    authorize! :update, @pool
    @pool.update_attribute(:published, true)
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
        pm = PoolMembership.create!({:user_id => u.id, :pool_id => @pool.id, :active => false})
      end
      redirect_to @pool
    end     
  end
  
  def join
    @pool = Pool.find(params[:id])
    authorize! :join, @pool
    pm = PoolMembership.where("user_id = ? and pool_id = ?", current_user.id, @pool.id)
    unless(pm.empty?)
      pm[0].update_attribute(:active, true)
    else
      pm = PoolMembership.new({:user_id => current_user.id, :pool_id => @pool.id, :active => true})
      unless(pm.save)
        redirect_to @pool, :error => "There is an error: please contact #{email}"
      end
    end
    redirect_to @pool, :notice => "You have joined the pool!"
  end
  
  def index
    @pools = Pool.all.each.select {|po| can? :see, po}
  end

  def show
    @pool = Pool.find(params[:id], :include => [:tournament, :q_answers])
    authorize! :read_summary, @pool
    @questions = @pool.q_answers.order("number asc")
    if can? :read, @pool
      @tournament = @pool.tournament
      @golfpicks = @pool.golfpicks.order("score asc #{", @(tiebreak - #{@tournament.low_score}) asc" if @tournament.low_score}, id asc")
    else
      @tournament = @pool.tournament
      @golfpicks = current_user.golfpicks.where("pool_id = ?", Pool.last.id)
      render 'summary'
    end
  end  

  def new
    @pool = Pool.new
    @tournament_options = getAvailableTournaments
    authorize! :create, @pool
  end
  
  def create
    @pool = Pool.new(params[:pool])
    @tournament_options = getAvailableTournaments
    authorize! :create, @pool
    @pool.tournament = Tournament.find(params[:pool]["tournament_id"]) 
    if(@pool.save)
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
  end
  




end
