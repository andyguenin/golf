class ApiController < ApplicationController
  def groups
    authorize! :index, :group
    respond_to do |format|
      format.json { render :json => current_user.groups.select([:name, :slug])}
    end
  end

  def group_pools
    @pools = Group.find_by_slug("blackrock").pools.joins("left outer join tournaments on tournaments.id = pools.tournament_id left outer join golfpicks on golfpicks.pool_id = pools.id left outer join users on golfpicks.user_id = users.id").select(["tournaments.name as tname", "pools.name as pname", "tournaments.location", "count(*) as usercount", "pools.id as pid"]).group(["tname", "pname", "location", "pid"]).to_json
    authorize! :read, @pools
    respond_to do |format|
      format.json { render :json => @pools }
    end  

  end
end
