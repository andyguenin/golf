class PagesController < ApplicationController
  def index
    if current_user
     @user = current_user
    else
      render 'anon'
    end
  end

  def about
#    authorize! :about, :page
 #   InviteMailer.invite(User.first).deliver
  end
end
