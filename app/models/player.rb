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
#

class Player < ActiveRecord::Base
  attr_accessible :name, :ranking, :slug

  validates_presence_of :name
  validates_presence_of :ranking

  has_many :scores
  has_many :player_score_statuses
  has_many :player_premia 
  has_many :tplayers
  has_many :tournaments, :through => :tplayers

  def to_param 
    slug
  end

  def self.update_score_from_scraper(score_structure, tourn)
    player = Player.find_by_name(score_structure[0])

    if player.nil?
      player = Player.create({:name => score_structure[0], :slug => score_structure[0].downcase.gsub(" ", "-"), :ranking => 0})
    end

    if player.tplayers.where("tournament_id = ?", tourn.id).empty?
      player.tplayers.create({:tournament => tourn, :bucket => 0, :score => 0})
    end

    holes = tourn.course.holes
    current_scores = player.scores_by_tournament(tourn)

    (score_structure.length-2).times do |t|
      score_structure[t+1].length.times do |u|
        actual_strokes = score_structure[t+1][u]
        current_score = current_scores[t][u]
        if current_score.nil?
          current_score = player.scores.new
          current_score.update_attributes({:tournament => tourn, :strokes => actual_strokes, :hole_id => holes[u].id, :round => t+1})
        else
          if current_score.strokes != actual_strokes
            current_score.update_attribute(:strokes, actual_strokes)
          end
        end
      end
    end

    player.update_score(tourn)
    
    tourn.update_attribute(:round, [[0,((Time.now - tourn.starttime)/60/60/24).floor].max + 1,4].max)
    a = score_structure[-1][0]
    player.tplayers.find_by_tournament_id(tourn.id).update_attribute(:status, a)
    
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
        scores_by_tournament_round(tournament, round).inject(0) do |sum, n|
          sum + (n.strokes - n.hole.par)
        end
  end

  def scores_by_tournament_round(tournament, round)
    self.scores.includes(:hole).where("tournament_id = ? and round = ?", \
        tournament.id, round).order("holes.hole_number asc")
  end

  def score_by_tournament(tournament)
    p = self.tplayers.find_by_tournament_id(tournament.id).score
  end

  def update_score(tournament)
    score = self.scores.includes(:hole).where("tournament_id = ?", \
            tournament.id).inject(0) {|sum, n| sum + (n.strokes - n.hole.par)}
    self.tplayers.where("tournament_id = ?", tournament.id)[0].update_attribute(:score, score)
    score
  end
end
