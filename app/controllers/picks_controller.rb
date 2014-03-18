class PicksController < ApplicationController
  
  def index
    
  end
  
  def show
  end
  
  def edit
    @title = "Edit Pick"
    @pick = Pick.find(params[:id])
    @pool = Pool.find(params[:pool_id])
    authorize! :edit, @pick
    redirect_to root_path unless @pick.pool.id == @pool.id
    @tplayers = @tplayers = @pool.tournament.tplayers.includes(:player).order("players.last_name asc")
  end
  
  def update
    @title = "Edit Pick"
    @pick = Pick.find(params[:id])
    @pool = Pool.find(params[:pool_id])
    authorize! :edit, @pick
    redirect_to root_path unless @pick.pool.id == @pool.id
    if(@pick.update_attributes(params[:pick]))
      @pick.update_score
      redirect_to @pool
    else
      @tplayers = @tplayers = @pool.tournament.tplayers.includes(:player).order("players.last_name asc")
      render 'edit'
    end      
  end
  
  def new
    @title = "New Pick"
    @pick = Pick.new
    @pool = Pool.find(params[:pool_id])
    @tplayers = @pool.tournament.tplayers.includes(:player).order("players.last_name asc")
  end
  
  def create
    @title = "New Pick"
    @pick = Pick.new(params[:pick])
    @pool = Pool.find(params[:pool_id])
    @pick.pool_membership = PoolMembership.where("user_id = ? and pool_id = ?", current_user.id, @pool.id)[0]
    if(@pick.save)
      @pick.update_score
      redirect_to @pool
    else
      @tplayers = @pool.tournament.tplayers.includes(:player).order("players.last_name asc")
      flash.now[:danger] = "There was an error creating the pool. Please input your choices for the fields highlighted in red."
      render 'new'
    end    
  end
  
  def destroy
    @pick = Pick.find(params[:id])
    @pool = Pool.find(params[:pool_id])
    authorize! :edit, @pick
    @pick.delete
    redirect_to @pool
  end
end
