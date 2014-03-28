class ScrapersController < ApplicationController
  authorize_resource :class => false
        

  def index
    @scrapers = Scraper.all
  end

  def new
    @scraper = Scraper.new
  end
  
  def create
    @scraper = Scraper.new(params[:scraper])
    if @scraper.save
      redirect_to scrapers_path
    else
      render 'new'
    end      
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
