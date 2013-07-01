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

require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
