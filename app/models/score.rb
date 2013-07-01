# == Schema Information
#
# Table name: scores
#
#  id            :integer          not null, primary key
#  tournament_id :integer
#  player_id     :integer
#  strokes       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  hole_id       :integer
#  round         :integer
#

class Score < ActiveRecord::Base
  attr_accessible :hole_id, :player_id, :strokes, :tournament_id

  validates_presence_of :hole_id
  validates_presence_of :player_id
  validates_presence_of :strokes
  validates_presence_of :tournament_id

  belongs_to :player
  belongs_to :tournament
  belongs_to :hole

end
