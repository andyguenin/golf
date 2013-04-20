class PlayerScoreStatus < ActiveRecord::Base
  attr_accessible :player_id, :score, :tournament_id

  belongs_to :player
  belongs_to :tournament
end
