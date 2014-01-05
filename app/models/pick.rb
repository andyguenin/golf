# == Schema Information
#
# Table name: picks
#
#  id                 :integer          not null, primary key
#  pool_membership_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  p1                 :integer
#  p2                 :integer
#  p3                 :integer
#  p4                 :integer
#  p5                 :integer
#  q1                 :boolean
#  q2                 :boolean
#  q3                 :boolean
#  q4                 :boolean
#  q5                 :boolean
#  tiebreak           :integer
#  score              :integer
#  approved           :boolean
#  approver           :integer
#

class Pick < ActiveRecord::Base
  attr_accessible :pool_membership_id, :p1, :p2, :p3, :p4, :p5, :q1, :q2, :q3, :q4, :q5, :tiebreak
  
  belongs_to :pool_membership
  has_one :user, :through => :pool_membership
  has_one :pool, :through => :pool_membership
  has_one :tournament, :through => :pool
  
  belongs_to :tp1, :class_name => "Tplayer", :foreign_key => "p1"
  belongs_to :tp2, :class_name => "Tplayer", :foreign_key => "p2"
  belongs_to :tp3, :class_name => "Tplayer", :foreign_key => "p3"
  belongs_to :tp4, :class_name => "Tplayer", :foreign_key => "p4"
  belongs_to :tp5, :class_name => "Tplayer", :foreign_key => "p5"
  
  has_one :pick1, :class_name => "Player", :through => :tp1, :source => :player
  has_one :pick2, :class_name => "Player", :through => :tp2, :source => :player
  has_one :pick3, :class_name => "Player", :through => :tp3, :source => :player
  has_one :pick4, :class_name => "Player", :through => :tp4, :source => :player
  has_one :pick5, :class_name => "Player", :through => :tp5, :source => :player
  
  validates_presence_of :p1, :p2, :p3, :p4, :p5, :tiebreak, :pool_membership
  validates :p1, numericality: {greater_than: 0}
  validates :p2, numericality: {greater_than: 0}
  validates :p3, numericality: {greater_than: 0}
  validates :p4, numericality: {greater_than: 0}
  validates :p5, numericality: {greater_than: 0}
  validates_inclusion_of :q1, :q2, :q3, :q4, :q5, :in => [true, false]
  
  after_initialize do
    self.p1 ||= 0
    self.p2 ||= 0
    self.p3 ||= 0
    self.p4 ||= 0
    self.p5 ||= 0
  end
  
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
#    s += (bonus || 0)
    self.update_attribute(:score, s)
  end
  
  def players
    [pick1, pick2, pick3, pick4, pick5]
  end
end
