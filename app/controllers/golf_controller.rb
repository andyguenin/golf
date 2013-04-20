class GolfController < ApplicationController
  def new
  end

  def edit
    
  end

  def index
    @tourneys = Tournament.where("endtime > ?", Time.now).order("endtime asc")
  end

  def show
  end
end
