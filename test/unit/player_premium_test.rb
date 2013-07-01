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

require 'test_helper'

class PlayerPremiumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
