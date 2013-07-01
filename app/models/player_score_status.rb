# == Schema Information
#
# Table name: player_score_statuses
#
#  id            :integer          not null, primary key
#  player_id     :integer
#  tournament_id :integer
#  score         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PlayerScoreStatus < ActiveRecord::Base
  attr_accessible :player_id, :score, :tournament_id

  belongs_to :player
  belongs_to :tournament
end
