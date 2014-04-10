class ScrapersController < ApplicationController
  authorize_resource :class => false
        

  def index
    @scrapers = Scraper.all
  end

  def new
    @scraper = Scraper.new
  end
  
  def create
    @scraper = Scraper.new(params[:scraper].merge({:user_id => current_user.id, :pause => true}))
    authorize! :create, @scraper
    if @scraper.save
      redirect_to scrapers_path
    else
      render 'new'
    end      
  end
  
  def pause
    @scraper = Scraper.find(params[:id])
    authorize! :mange, @scraper
  end
  
  def play
    @scraper = Scraper.find(params[:id])
    authorize! :manage, @scraper
    @scraper.play_s
    @scraper.reload
    redirect_to scrapers_path
  end
  
  def pause
    @scraper = Scraper.find(params[:id])
    authorize! :manage, @scraper
    @scraper.pause_s
    redirect_to scrapers_path
  end
  
  def run_once
    @scraper = Scraper.find(params[:id])
    authorize! :manage, @scraper
    @scraper.scrape
    redirect_to scrapers_path
  end
  
  
  def edit
    @scraper = Scraper.find(params[:id])
  end
  
  def update
    @scraper = Scraper.find(params[:id])
  end
  
  def destroy
    @scraper = Scraper.find(params[:id])
  end
end
