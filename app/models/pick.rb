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
#  bonus              :integer
#  active_players     :integer
#  name               :string(255)
#  slug               :string(255)
#

class Pick < ActiveRecord::Base
  attr_accessible :pool_membership_id, :p1, :p2, :p3, :p4, :p5, :q1, :q2, :q3, :q4, :q5, :tiebreak, :score, :bonus, :active_players, :name
  
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
  
  validates_presence_of :p1, :p2, :p3, :p4, :p5, :tiebreak, :pool_membership, :name
  validates :p1, numericality: {greater_than: 0}
  validates :p2, numericality: {greater_than: 0}
  validates :p3, numericality: {greater_than: 0}
  validates :p4, numericality: {greater_than: 0}
  validates :p5, numericality: {greater_than: 0}
  validates_inclusion_of :q1, :q2, :q3, :q4, :q5, :in => [true, false]
  validate :validate_name_uniqueness

  before_validation :fix_name
  before_save :create_slug
  
  after_initialize do
    self.p1 ||= 0
    self.p2 ||= 0
    self.p3 ||= 0
    self.p4 ||= 0
    self.p5 ||= 0
  end

  def to_param
    self.slug
  end
  
  def player_subscore
    scores = players.map{|p| p.get_tplayer(pool.tournament).score}
    max = scores.max
    scores = scores.select{|t| t != max}
    scores.fill(max, scores.length, 4-scores.length)
    scores.sum
  end
  
  def correct_questions
    [q1,q2,q3,q4,q5].zip(pool.q_answers.map{|a| a[1]}).select do |a|
      a[0] == a[1] and not a[0].nil?
    end.length
  end

  def update_score
    s = player_subscore
    s -= correct_questions
    num_active_players = players.map do |p| 
      status = p.get_tplayer(tournament).status
      status <=1 or status == 5
    end.length
    s -= num_active_players == 5 ? 3 : 0
    self.update_attributes!({:score => s, :bonus => num_active_players == 5 ? -3 : 0, :active_players => num_active_players})
  end
  
  def players
    [pick1, pick2, pick3, pick4, pick5]
  end

  private
  def create_slug
    slugs = pool.picks.map {|p| p.slug}
    s = self.name.downcase.gsub(/[^a-z0-9\s]/,'').gsub(" ","-")
    while slugs.include? s
      s += "-0"
    end
    self.slug = s
  end

  def validate_name_uniqueness
    s_pool = pool.picks.find_by_name(self.name)
    if not s_pool.nil? and s_pool.id != self.id
      errors.add(:name, "has already been taken")
    end
  end

  def fix_name
    self.name = name.strip.squish
  end

end
