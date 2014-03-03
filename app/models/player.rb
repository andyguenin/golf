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

    holes = tourn.course.holes
    current_scores = player.scores_by_tournament(tourn)
    pars = tourn.course.holes.map {|h| h.par}
    freq = []
    9.times do |t|
      freq << 0
    end
    curr_round = 0
    curr_hole = 0

    unless score_structure.length == 1
      existing_rounds = tplayer.rounds
      if existing_rounds.length != score_structure.length-2
        Round.create_round(score_structure[existing_rounds.length+1], existing_rounds.length+1, tplayer)
        existing_rounds = player.get_tplayer(tourn).rounds
      end
      (score_structure.length-2).times do |t|
        existing_rounds[t].update_scores(score_structure[t+1])
        stats = [0,0,0,0,0]
        existing_rounds.length.times do |u|
          stats = Round.stats_combiner(existing_rounds[u].score_stats, stats)
        end
      end
    
      player.update_score(tourn, score_structure[-2], score_structure[-1])
      tplayer.update_attributes({:deagle => freq[1], :eagle => freq[2], :birdie => freq[3], :par => freq[4], :bogey => freq[5], :dbogey => freq[6], :tbogey => freq[7]})
      tourn.update_attribute(:round, [[0,((Time.now - tourn.starttime)/60/60/24).floor].max + 1,4].min)   
    end
  end

  def scores_by_tournament(tournament)
    hm = [[],[],[],[]]
    scores = self.scores.includes(:hole).where("tournament_id = ?", tournament.id). \
      order("round asc, holes.hole_number asc")
    scores.each do |score|
      hm[score.round-1][score.hole.hole_number - 1] = score
    end
    hm
  end

  def score_by_tournament_round(tournament, round)
        a = scores_by_tournament_round(tournament, round).inject(0) do |sum, n|
          sum + (n.strokes - n.hole.par)
        end        
  end

  def scores_by_tournament_round(tournament, round)
    self.scores.includes(:hole).where("tournament_id = ? and round = ?", \
        tournament.id, round).order("holes.hole_number asc")
  end

  def score_by_tournament(tournament)
    p = self.tplayers.find_by_tournament_id(tournament.id).score || 0
  end

  def get_tplayer(tournament)
    self.tplayers.where("tournament_id = ?", tournament.id)[0]
  end
  
  def update_score(tournament, score, status)
    dnf = 1
    a = 0
    begin
      a = Integer(status)
    rescue ArgumentError, TypeError
      unless a.to_s == score
        unless status == "F"
          score = 100
          if status == "WD"
            dnf = 4
          elsif status == "CUT"
            dnf = 3
          elsif status == "MDF"
            dnf = 2
          end
        end
      end
    end
    get_tplayer(tournament).update_attributes({:score => score, :status => dnf})
  end
end
