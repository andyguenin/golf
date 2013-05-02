class Tournament < ActiveRecord::Base
  attr_accessible :endtime, :location, :name, :starttime

  
  def to_param
    self.slug
  end

  has_many :pools
  has_many :scores
  has_many :player_score_statuses
  has_one :course
  has_many :tplayers
  has_many :players, :through => :tplayers

end
