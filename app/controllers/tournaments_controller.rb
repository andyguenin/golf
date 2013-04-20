class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find_by_slug(params[:id], :include => :players)
    @holes = @tournament.course.holes.order("hole_number asc")
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
    @tournament = Tournament.find(params[:id])
    authorize! :destroy, @tournament
    @tournament.destroy
    redirect_to tournament_url
  end
end
