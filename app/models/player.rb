# == Schema Information
#
# Table name: players
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  ranking         :integer
#  slug            :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  pga_rank        :integer
#  pga_rank_update :date
#  pga_rank_status :string(255)
#

class Player < ActiveRecord::Base
  attr_accessible :ranking, :slug, :first_name, :last_name, :pga_rank, :pga_rank_update, :pga_rank_status, :name

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :ranking

  validates_uniqueness_of :first_name, scope: [:last_name, :slug]
  
  has_many :player_score_statuses
  has_many :player_premia, :through => :tplayers
  has_many :tplayers, :dependent => :destroy
  has_many :tournaments, :through => :tplayers

  def to_param 
    slug
  end

  def name
    "#{first_name} #{last_name}"
  end

  def self.update_score_from_scraper(score_structure, tourn)
    name_regex = /^(.*)\s(\S+)$/
    match = name_regex.match(score_structure[0])
    
    player = Player.where("first_name = ? and last_name = ?", match[1], match[2])[0]

    if player.nil?
      player = Player.create!({:name => score_structure[0], :first_name => match[1], :last_name => match[2], :slug => score_structure[0].downcase.gsub(" ", "-"), :ranking => 0})
    end

    tplayer = player.get_tplayer(tourn)
    if tplayer.nil?
      tplayer = player.tplayers.create!({:tournament => tourn, :bucket => 0, :score => 0, :status => 6})
    end
    unless score_structure.length == 1
      existing_rounds = tplayer.rounds
      (score_structure.length-3).times do |r|
        if((r) < existing_rounds.length)
          tplayer.get_round(r+1).update_strokes(score_structure[r+1])
        else
          Round.create_round(score_structure[r+1], r+1, tplayer)
        end
      end
      tplayer.update_score(score_structure[-1])
    end
  end

  def self.update_pga_rankings
    require 'net/http'
    response = Net::HTTP.get_response("www.kimonolabs.com", "/api/57e143n8?apikey=0f4df33b701889c3fb3b542b8298cc84")
    ds = JSON.parse(response.body)
    status = ds["results"]["collection1"][0]["property1"]
    ds["results"]["collection2"].each do |rec|
      unless rec["property2"]["text"].nil?
        player = Player.find_by_name(rec["property2"]["text"].gsub("\u00A0", " "))
        unless player.nil?
          player.update_attributes({:pga_rank => rec["property3"].to_i, :pga_rank_update => Time.now, :pga_rank_status => status})
        end
      end
    end
  end

  def scores_by_tournament(tournament)
    get_tplayer(tournament).rounds.map {|r| r.as_vec}
  end


  def get_tplayer(tournament)
    self.tplayers.where("tournament_id = ?", tournament.id)[0]
  end
  
  def get_premium(pool)
    get_tplayer(pool.tournament).get_premium_by_pool(pool)
  end
  

end
