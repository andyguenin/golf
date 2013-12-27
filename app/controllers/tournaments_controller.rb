class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def current
    @tournament = Tournament.last
    render 'show'
  end
  
  def show
    @tournament = Tournament.find_by_slug(params[:id], :include => :players)
  end

  def edit
    @tournament = Tournament.find_by_slug(params[:id])
    authorize! :edit, @tournament
  end

  def update
    @tournament = Tournament.find_by_slug(params[:id])
    authorize! :edit, @tournament
    if @tournament.update_attributes(params[:tournament])
      redirect_to @tournament
    else
      render 'edit'
    end
  end

  def new
    @tournament = Tournament.new
    authorize! :new, @tournament
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    @tournament.slug = params[:tournament][:slug]
    authorize! :create, @tournament
    if @tournament.save
      redirect_to @tournament
    else
      render 'new'
    end
  end

  def destroy
    @tournament = Tournament.find_by_slug(params[:id])
    authorize! :destroy, @tournament
    @tournament.destroy
    redirect_to tournament_url
  end

  def player
    @tournament = Tournament.find_by_slug(params[:id])
    @player = Player.find_by_slug(params[:player])
    unless @tournament.players.include? @player
      render :text => "player is not in tournament"
    end
  end


end
