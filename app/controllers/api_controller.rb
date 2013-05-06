class ApiController < ApplicationController
  def groups
    authorize! :index, :group
    respond_to do |format|
      format.json { render :json => current_user.groups.select([:name, :slug]).order("name")}
    end
  end

  def group_pools
    pools = "Not authorized"
    begin 
      pools = Group.find_by_slug(params[:id]).pools.joins("left outer join tournaments on tournaments.id = pools.tournament_id left outer join golfpicks on golfpicks.pool_id = pools.id left outer join users on golfpicks.user_id = users.id").select(["tournaments.name as tname", "pools.name as pname", "tournaments.location", "count(*) as usercount", "pools.id as s_pool_id", "tournaments.starttime", "tournaments.endtime" ]).order("tournaments.starttime").group(["tname", "pname", "location", "s_pool_id", "starttime", "endtime"])
      authorize! :read, @pools
    rescue
    end
    respond_to do |format|
      format.json { render :json => pools.to_json }
    end  
  end

  def tournament_standings
    tournament = Tournament.joins(:course).select(["tournaments.name as tournament_name", "tournaments.location", "tournaments.starttime", "tournaments.endtime", "tournaments.slug", "courses.name as course_name", "tournaments.id"]).find_by_slug(params[:id])
    holes = Hole.where("course_id = ?", tournament.id).order(:hole_number).select(["hole_number", "par"])
    players = Tournament.find_by_slug(params[:id]).players.map{|p| [p.name, p.scores_by_tournament(Tournament.first)]}
    
    respond_to do |format|
      format.json { render :json => 
        {
          :tournament => tournament.attributes.reject {|k,v| k=="id"}, 
          :holes => holes,
          :players => players
        }.to_json}
    end
  end 
end
