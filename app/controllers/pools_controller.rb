class PoolsController < ApplicationController

  def index
    redirect_to groups_path
  end

  def show
    @pool = Pool.find(params[:id], :include => [:group, :tournament])
    authorize! :view, @pool
  end

  def edit
  end

  def new
  end
end
