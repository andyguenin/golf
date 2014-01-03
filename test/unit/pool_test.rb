# == Schema Information
#
# Table name: pools
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  tournament_id   :integer
#  min_units       :integer
#  name            :string(255)
#  published       :boolean
#  private         :boolean
#  nonadmin_invite :boolean
#


require 'test_helper'

class PoolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
