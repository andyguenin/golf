class PicksController < ApplicationController
  
  def index
  end
  
  def show
  end
  
  def edit
    @pick = Pick.find(params[:id])
    @pool = Pool.find(params[:pool_id])
    redirect_to root_path unless @pick.pool.id == @pool.id
    @tplayers = @tplayers = @pool.tournament.tplayers.includes(:player).order("players.last_name asc")
  end
  
  def update
    @pick = Pick.find(params[:id])
    @pool = Pool.find(params[:pool_id])
    redirect_to root_path unless @pick.pool.id == @pool.id
    if(@pick.update_attributes(params[:pick]))
      redirect_to @pool
    else
      @tplayers = @tplayers = @pool.tournament.tplayers.includes(:player).order("players.last_name asc")
      render 'edit'
    end      
  end
  
  def new
    @pick = Pick.new
    @pool = Pool.find(params[:pool_id])
    @tplayers = @pool.tournament.tplayers.includes(:player).order("players.last_name asc")
  end
  
  def create
    @pick = Pick.new(params[:pick])
    @pool = Pool.find(params[:pool_id])
    @pick.pool_membership = PoolMembership.where("user_id = ? and pool_id = ?", current_user.id, @pool.id)[0]
    if(@pick.save)
      redirect_to @pool
    else
      @tplayers = @pool.tournament.tplayers.includes(:player).order("players.last_name asc")
      flash.now[:error] = "There was an error creating the pool: #{@pick.errors.each {|t| t.to_s}}"
      render 'new'
    end    
  end
  
  def destroy
  end
end
