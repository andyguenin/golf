class Tplayer< ActiveRecord::Base
  attr_accessible :bucket, :player_id, :tournament_id

  validates :bucket, :inclusion => 1..5

  belongs_to :tournament
  belongs_to :player
end
