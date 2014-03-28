class InvitesController < ApplicationController
  
  def index
    authorize! :admin, NonmemberInvitee.new
    @invites = NonmemberInvitee.all
  end

  def show
    authorize! :be_invited, current_user
    @invites = current_user.invites
  end
end
