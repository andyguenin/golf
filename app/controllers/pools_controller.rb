class PoolsController < ApplicationController
  helper_method :get_pools_attributes

  def index
    @pools = Pool.all
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
    authorize! :create, @pool
  end

  def create
    @pool = Pool.new(params[:pool].slice("name"))
    authorize! :create, @pool
    @pool.tournament = Tournament.find_by_slug(params[:pool]["tournament_id"]) 
    if(@pool.save and @pool.update_attributes(params[:pool]))
      redirect_to @pool
    else
      render 'new'
    end
  end



end
