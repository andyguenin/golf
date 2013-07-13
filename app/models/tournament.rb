# == Schema Information
#
# Table name: tournaments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  location   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  starttime  :datetime
#  endtime    :datetime
#  slug       :string(255)
#  round      :integer
#  low_score  :integer
#  locked     :boolean
#

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
