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

require 'test_helper'

class PlayerScoreStatusTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
