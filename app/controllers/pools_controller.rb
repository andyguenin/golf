class PoolsController < ApplicationController

  def index
    redirect_to groups_path
  end

  def show
    @pool = Pool.find(params[:id], :include => [:group, :tournament, :q_answers])
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
      redirect_to [@pool.group, @pool]
    else
      render 'edit'
    end
  end

  def new
    @pool = Pool.new
    authorize! :create, @pool
  end

  def create
    @pool = Pool.new(params[:pool])
    @pool.slug = params[:pool][:slug]
    autorize! :create, @pool
    if(@pool.save)
      redirect_to [@pool.group, @pool]
    else
      render 'new'
    end
  end
end
