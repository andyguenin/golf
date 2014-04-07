class PicksController < ApplicationController
  
  def index
    
  end
  
  def show
    @pool = Pool.find_by_slug(params[:pool_id])
    @pick = @pool.all_picks.where("slug = ?", params[:id])[0]
  end
  
  def edit
    @title = "Edit Pick"
    @pool = Pool.find_by_slug(params[:pool_id])
    @pick = @pool.picks.where("slug = ?", params[:id])[0]
    authorize! :edit, @pick
    redirect_to root_path unless @pick.pool.id == @pool.id
    @tplayers = @tplayers = @pool.tournament.tplayers.includes(:player).order("players.pga_rank asc")
  end
  
  def update
    @title = "Edit Pick"
    @pool = Pool.find_by_slug(params[:pool_id])
    @pick = @pool.picks.where("slug = ?", params[:id])[0]
    authorize! :edit, @pick
    redirect_to root_path unless @pick.pool.id == @pool.id
    if(@pick.update_attributes(params[:pick]))
      if @pick.received_unit != @pick.cost
        @pick.approver = nil
        @pick.approved = false
        @pick.save
      end
      @pick.update_score
      redirect_to @pool
    else
      @tplayers = @pool.tournament.tplayers.includes(:player).order("players.last_name asc")
      er = "There was an error creating the pick. Please input your choices for the fields highlighted in red."
      if @pick.errors[:name] and @pick.errors[:name][0] == "has already been taken"
        er = "The title of your pick has already been used in this pool. Please choose a new name."
      end
      flash.now[:danger] = er
      render 'edit'
    end      
  end
  
  def new
    @title = "New Pick"
    @pool = Pool.find_by_slug(params[:pool_id])
    @pick = @pool.picks.new
    @tplayers = @pool.tournament.tplayers.includes(:player).order("players.pga_rank asc")
    @pick.name = "#{current_user.name}'s Team #{current_user.pool_memberships.where("pool_id = ?", @pool.id)[0].picks.size + 1}"
  end
  
  def create
    @title = "New Pick"
    @pool = Pool.find_by_slug(params[:pool_id])
    @pick = @pool.picks.new(params[:pick])
    @pick.approved = false
    @pick.received_unit = 0
    @pick.pool_membership = PoolMembership.where("user_id = ? and pool_id = ?", current_user.id, @pool.id)[0]
    if(@pick.save)
      @pick.update_score
      redirect_to @pool
    else
      @tplayers = @pool.tournament.tplayers.includes(:player).order("players.pga_rank asc")
      er = "There was an error creating the pool. Please input your choices for the fields highlighted in red."
      er = @pick.errors.first
      if @pick.errors[:name] == "has already been taken"
        er = "The title of your pick has already been used in this pool. Please choose a new name."
      end
      flash.now[:danger] = er
      render 'new'
    end    
  end
  
  def destroy
    @pool = Pool.find_by_slug(params[:pool_id])
    @pick = @pool.all_picks.where("slug = ?", params[:id])[0]
    authorize! :edit, @pick
    @pick.delete
    redirect_to @pool
  end
  
  def approve
    @pool = Pool.find_by_slug(params[:pool_id])
    @pick = @pool.pending_picks.where("slug = ?", params[:id])[0]
    authorize! :manage, @pool
    @pick.approve(current_user)
    redirect_to pool_path @pool
  end
  
  def reject
    @pool = Pool.find_by_slug(params[:pool_id])
    @pick = @pool.pending_picks.where("slug = ?", params[:id])[0]
    authorize! :manage, @pool
    @pick.delete
    redirect_to pool_path @pool    
  end
end
