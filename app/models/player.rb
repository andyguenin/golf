class Player < ActiveRecord::Base
  attr_accessible :name, :ranking

  validates_presence_of :name
  validates_presence_of :ranking

  has_many :scores
  has_many :player_score_statuses
  has_many :player_premia 
  has_many :tplayers
  has_many :tournaments, :through => :tplayers

  def scores_by_tournament(tournament)
    self.scores.where("tournament_id = ?", tournament.id)
  end

  def scores_by_tournament_round(tournament, round)
    self.scores.includes(:hole).where("tournament_id = ? and round = ?", tournament.id, round).order("holes.hole_number asc")
  end

  def score_by_tournament(tournament)
    self.scores.includes(:hole).where("tournament_id = ?", tournament.id)
      .inject(0) {|sum, n| sum + (n.strokes - n.hole.par)}
  end
end
