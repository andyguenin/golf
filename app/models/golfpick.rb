class Golfpick < ActiveRecord::Base
  belongs_to :user
  belongs_to :pool

  belongs_to :pick1, :class_name => "Player", :foreign_key => "pick1"
  belongs_to :pick2, :class_name => "Player", :foreign_key => "pick2"
  belongs_to :pick3, :class_name => "Player", :foreign_key => "pick3"
  belongs_to :pick4, :class_name => "Player", :foreign_key => "pick4"
  belongs_to :pick5, :class_name => "Player", :foreign_key => "pick5"

  attr_accessible :pick1, :pick2, :pick3, :pick4, :pick5, :q1, :q2, :q3, :q4, :q5, :tiebreak, :user_id

  def initialize
    @players = [1,2]
  end
 
  def player_subscore
    players.inject(0) do |sum, p|
      sum = sum + p.score_by_tournament(pool.tournament)
    end
  end


  def update_score
    s = player_subscore
    (1..5).each do |n|
      s += self.send("q#{n}") ? -1 : 0
    end
    self.score = s
  end


  private
  def players
    [pick1, pick2, pick3, pick4, pick5]
  end



end
