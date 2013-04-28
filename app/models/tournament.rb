class Tournament < ActiveRecord::Base
  attr_accessible :endtime, :location, :name, :starttime

  before_save :default_values
  
  def to_param
    self.slug
  end

  has_many :pools
  has_many :scores
  has_many :player_score_statuses
  has_one :course
  has_many :tplayers
  has_many :players, :through => :tplayers

  def default_values
    self.low_score ||= 0
  end
end
