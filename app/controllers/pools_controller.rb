class PoolsController < ApplicationController
  helper_method :get_pools_attributes

  def index
    @pools = Pool.where("private = ? or private = ?", false, nil)
  end

  def show
    @pool = Pool.find(params[:id], :include => [:tournament, :q_answers])
    authorize! :read, @pool
    @tournament = @pool.tournament
    @golfpicks = @pool.golfpicks.order("score asc #{", @(tiebreak - #{@tournament.low_score}) asc" if @tournament.low_score}, id asc")
    @questions = @pool.q_answers.order("number asc")
  end

  def edit
    @pool = Pool.find(params[:id])
    @tournament_options = Tournament.where("starttime > ?", Time.now)
    authorize! :update, @pool
  end

  def update
    @pool = Pool.find(params[:id])
    authorize! :update, @pool
    if(@pool.update_attributes(params[:pool]))
      redirect_to @pool
    else
      render 'edit'
    end
  end

  def new
    @pool = Pool.new
    @tournament_options = Tournament.where("starttime > ?", Time.now)
    authorize! :create, @pool
  end
  
  def publish
    @pool = Pool.find(params[:id])
    authorize! :update, @pool
    @pool.update_attribute(:published, true)
    @pool.save
    redirect_to pool_path(@pool)
  end

  def invite
    @pool = Pool.find(params[:id])
    authorize! :invite, @pool
    @emails = params[:emails] ? params[:emails].split("\n").join(" ").split("\r").join(" ").scan(/([a-zA-Z]\S*@[a-zA-Z\.]*)/).map {|t| t[0]} : []
  end
  
  def create
    @pool = Pool.new(params[:pool])
    @tournament_options = Tournament.where("starttime > ?", Time.now)
    authorize! :create, @pool
    @pool.tournament = Tournament.find(params[:pool]["tournament_id"]) 
    if(@pool.save)
      redirect_to @pool
    else
      render 'new'
    end
  end



end
