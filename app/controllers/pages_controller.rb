class PagesController < ApplicationController
  def index
    if current_user
      @pools = current_user.pools.includes(:tournament).where("tournaments.endtime > ?", Time.now)
      if @pools.length == 1
        redirect_to pool_path(@pools[0])
      end
    end
  end

  def about
#    authorize! :about, :page
 #   InviteMailer.invite(User.first).deliver
  end
  
  def works
    
  end
end
