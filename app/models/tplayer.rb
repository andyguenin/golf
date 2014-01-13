# == Schema Information
#
# Table name: tplayers
#
#  id            :integer          not null, primary key
#  player_id     :integer
#  tournament_id :integer
#  bucket        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  score         :integer
#  status        :integer
#  deagle        :integer
#  eagle         :integer
#  birdie        :integer
#  par           :integer
#  bogey         :integer
#  dbogey        :integer
#  tbogey        :integer
#  round         :integer
#  hole          :integer
#  rank          :string(255)
#

class Tplayer< ActiveRecord::Base
  attr_accessible :bucket, :player_id, :tournament, :score, :status, :deagle, :eagle, :birdie, :par, :bogey, :dbogey, :tbogey, :round, :hole, :rank

  #status: 0> won 1>playing/finished 2> mdf 3> cut 4> wd 5> did not start 
  validates :bucket, :inclusion => 0..5
  validates_presence_of :player_id
  validates_presence_of :tournament_id
  validates_presence_of :score
  validates_presence_of :status
  validates_presence_of :deagle, :eagle, :birdie, :par, :bogey, :dbogey, :tbogey
  validates_presence_of :round, :hole, :rank
  
  after_initialize :set_default
  
  def set_default
    [:deagle, :eagle, :birdie, :par, :bogey, :dbogey, :tbogey, :round, :hole, :rank].each do |t|
      self[t] ||= 0
    end
  end

  belongs_to :tournament
  belongs_to :player
end
