class PlayersController < ApplicationController
  def show
    @player = Player.find_by_slug(params[:id])
  end

  def edit
  end

  def new
  end

  def index
  end
end
