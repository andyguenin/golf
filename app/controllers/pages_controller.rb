class PagesController < ApplicationController
  def index
    if current_user
     @user = current_user
     render 'users/show'
    else
      render 'anon'
    end
  end

  def about
    authorize! :about, :page
  end
end
