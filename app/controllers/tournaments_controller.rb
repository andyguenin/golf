class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def current
    @tournament = Tournament.last
    render 'show'
  end
  
  def current
    @tournament = Tournament.last
    if @tournament.nil?
      redirect_to root_path
    else
      @players = @tournament.players.includes(:tplayers => :rounds).all.sort_by do |t|
        u = t.get_tplayer(@tournament)
        [u.status, u.score, -u.hole, t.last_name]
      end
      render 'show'     
    end
  end
  
  def show
    @tournament = Tournament.find_by_slug(params[:id], :include => :players)
    @players = @tournament.players.includes(:tplayers => :rounds).all.sort_by do |t| 
      u = t.get_tplayer(@tournament)
      [u.status, u.score, -u.hole, t.last_name]
    end
  end

  def edit
    @tournament = Tournament.find_by_slug(params[:id])
    authorize! :edit, @tournament
  end

  def update
    @tournament = Tournament.find_by_slug(params[:id])
    authorize! :edit, @tournament
    updates = JSON.parse(Base64.decode64(params[:bucketing_data]))
    updates.each do |tp|
      t = Tplayer.where("id = ? and tournament_id = ?", tp[0], @tournament.id)[0]
      t.update_attribute(:bucket, tp[1])
    end
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
