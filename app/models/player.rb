# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ranking    :integer
#  slug       :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#

class Player < ActiveRecord::Base
  attr_accessible :ranking, :slug, :first_name, :last_name

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :ranking

  validates_uniqueness_of :first_name, scope: [:last_name, :slug]
  
  has_many :scores
  has_many :player_score_statuses
  has_many :player_premia 
  has_many :tplayers
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
      player = Player.create!({:first_name => match[1], :last_name => match[2], :slug => score_structure[0].downcase.gsub(" ", "-"), :ranking => 0})
    end

    tplayer = player.get_tplayer(tourn)
    if tplayer.nil?
      tplayer = player.tplayers.create!({:tournament => tourn, :bucket => 0, :score => 0, :status => 5})
    end
    unless score_structure.length == 1
      existing_rounds = tplayer.rounds
      if existing_rounds.length != score_structure.length-3
        (score_structure.length-existing_rounds.length-3).times do |r|
          c_round = r + 1
          Round.create_round(score_structure[c_round], c_round, tplayer)
        end
        existing_rounds = tplayer.rounds
      end
      tplayer.update_score(score_structure[-1])
      tourn.update_attribute(:round, [[0,((Time.now - tourn.starttime)/60/60/24).floor].max + 1,4].min)   
    end
  end

  def scores_by_tournament(tournament)
    get_tplayer(tournament).rounds.map {|r| r.as_vec}
  end


  def get_tplayer(tournament)
    self.tplayers.where("tournament_id = ?", tournament.id)[0]
  end
  

end
