# == Schema Information
#
# Table name: golfpicks
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  pick1          :integer
#  pick2          :integer
#  pick3          :integer
#  pick4          :integer
#  pick5          :integer
#  q1             :boolean
#  q2             :boolean
#  q3             :boolean
#  q4             :boolean
#  q5             :boolean
#  tiebreak       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  score          :integer
#  bonus          :integer
#  pool_member_id :integer
#

class Golfpick < ActiveRecord::Base
  belongs_to :user
  belongs_to :pool_membership

  belongs_to :pick1, :class_name => "Player", :foreign_key => "pick1"
  belongs_to :pick2, :class_name => "Player", :foreign_key => "pick2"
  belongs_to :pick3, :class_name => "Player", :foreign_key => "pick3"
  belongs_to :pick4, :class_name => "Player", :foreign_key => "pick4"
  belongs_to :pick5, :class_name => "Player", :foreign_key => "pick5"

#  attr_accessible :pick1, :pick2, :pick3, :pick4, :pick5, :q1, :q2, :q3, :q4, :q5, :tiebreak, :user_id

  def player_subscore
    players.inject(0) do |sum, p|
      sum = sum + p.score_by_tournament(pool.tournament)
    end
  end


  def update_score
    s = player_subscore
    as = pool.q_answers.order("number asc")
    5.times do |t|
      s -= as.all[t].answer.nil? ? 0 : (self.send("q#{t+1}") == as.all[t].answer ? 1 : 0)
    end
    s += bonus
    self.update_attribute(:score, s)
  end


  private
  def players
    [pick1, pick2, pick3, pick4, pick5]
  end



end
