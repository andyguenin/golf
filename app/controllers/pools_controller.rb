class PoolsController < ApplicationController
  helper_method :get_pools_attributes

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
    get_pools_attributes(params[:group_id])
  end

  def create
    @pool = Pool.new(params[:pool])
    authorize! :create, @pool
    get_pools_attributes(params[:group_id])
    @pool.group = @group
    @pool.tournament = @tournament
    if(@pool.save)
      redirect_to [@pool.group, @pool]
    else
      render 'new'
    end
  end

  private
  def get_pools_attributes(slug)
    @group = Group.find_by_slug(slug)
    @tournament_options = Tournament.where("starttime > ?", Time.now).map { |t| ["#{t.name}#{@group.pools.map{|p| p.tournament}.include?(t) ? " (pool exists for group)" : ""}" , t.slug] }
  end


end
