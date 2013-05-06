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

  def scores_by_tournament(tournament)
    hm = [[],[],[],[]]
    scores = self.scores.includes(:hole).where("tournament_id = ?", tournament.id). \
      order("round asc, holes.hole_number asc")
    scores.each do |score|
      hm[score.round-1][score.hole.hole_number - 1] = score.strokes
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
    p = player_score_statuses.find_by_tournament_id tournament.id
    if(p.nil?)
      p = self.player_score_statuses.create({:tournament_id => tournament.id, \
                                        :score => 100})
    end
    if p.updated_at < 1.minute.ago || (p.created_at > 1.minute.ago and p.score == 100)
      update_score tournament, p
    else
      p.score
    end
  end

  private
    def update_score(tournament, pss)
      score = self.scores.includes(:hole).where("tournament_id = ?", \
            tournament.id).inject(0) {|sum, n| sum + (n.strokes - n.hole.par)}
      pss.update_attribute(:score, score)
      score
    end
end
