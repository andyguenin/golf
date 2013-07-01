# == Schema Information
#
# Table name: player_premia
#
#  id         :integer          not null, primary key
#  pool_id    :integer
#  player_id  :integer
#  premium    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PlayerPremium < ActiveRecord::Base
  attr_accessible :player_id, :pool_id, :premium
end
