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
#

class Tplayer< ActiveRecord::Base
#  attr_accessible :bucket, :player_id, :tournament_id, :score

  validates :bucket, :inclusion => 1..5
  validates_presence_of :player_id
  validates_presence_of :tournament_id
  validates_presence_of :score

  belongs_to :tournament
  belongs_to :player
end
