# == Schema Information
#
# Table name: player_premia
#
#  id         :integer          not null, primary key
#  pool_id    :integer
#  premium    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tplayer_id :integer
#

class PlayerPremium < ActiveRecord::Base
  attr_accessible :tplayer_id, :pool_id, :premium
  validates_uniqueness_of :pool_id, scope: [:tplayer_id]
  
  belongs_to :pool
  belongs_to :tplayer
  after_initialize :set_defaults
  
  def set_defaults
    self.premium ||= 0
  end
end
