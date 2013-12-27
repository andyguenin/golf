#this file is just for reference until we fold all methods here back into their correct controller.


class ApiController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  def is    
    password = "RLMMKTeFNtPZEBxsbx8g3Ou0HxniC3l5wAmJUcwsGotZHvbImkOwbPQigcddFWgM"
    enc_message = params[:scores]
    message = AESCrypt.decrypt(Base64.decode64(enc_message), password)

    ds = JSON.parse(message)
    start_time = Time.parse("#{ds[0][1]} #{ds[0][2]} #{ds[0][4]}")
    end_time = Time.parse("#{ds[0][1]} #{ds[0][3] + 1} #{ds[0][4]}")

    t_name = ds[0][0]
    t_location = /(.*)\s\|.*/.match(ds[0][5])[1]

    t = Tournament.where("name = ? and starttime = ?", t_name, start_time)[0]
    if t.nil?
      t = Tournament.new
      t.name = t_name
#      t.location = t_location
      t.starttime = start_time
      t.endtime = end_time
      t.slug = "#{ds[0][0]} #{ds[0][4]}".downcase.gsub(" ", "-")
      t.round = 1
      t.locked = false
      t.save
      
      location_info = /(.*)\s-\s(.*)/.match(t_location)
      course = Course.where("name = ? and location = ?", location_info[1], location_info[2])[0]
      if course.nil?
        course = t.create_course({:name => location_info[1], :location => location_info[2]})
        ds[1][0].length.times do |t|
          course.holes.create({:hole_number => t+1, :par => ds[1][0][t]})
        end
      end
      t.update_attribute(:course, course)
    end

    ds[1][1].each do |player|
      Player.update_score_from_scraper(player, t)
    end
#    puts ds    

    render :text => "success"
  end
  
  def groups
    return 0
    authorize! :index, :group
    respond_to do |format|
      format.json { render :json => current_user.groups.select([:name, :slug]).order("name")}
    end
  end

  def group_pools
    return 0
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
    return 0
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
  
  def insert_score
    
    #get the necessary values
    player = Player.find(params[:player_id])
    tournament = player.tournaments.find(params[:tournament_id])
    hole = tournament.course.holes.find_by_hole_number(params[:hole])

    #build the score object
    score = tournament.scores.build
    score.player = player
    score.hole = hole
    score.strokes = params[:strokes]
    score.round = params[:round]
    
    #make sure we aren't overwriting one
    exists = !Score.where("player_id = ? and tournament_id = ? and hole_id = ? and round = ?", score.player_id, score.tournament_id, score.hole_id, score.round).empty?
    

    
    respond_to do |format|
      format.json do
        if !exists and score.save
          #update the db cached players score
          tplayer = tournament.tplayers.find_by_player_id(player.id)
          tplayer.update_attribute(:score, tplayer.score + score.delta)

          render :json => score.to_json
        else
          if exists
            render :json => "score for that key already exists".to_json
          else
            render :json => score.errors.flat_map {|d| "#{d} #{score.errors[d]};"}.to_json
          end
        end
      end
    end
    
  end
end
