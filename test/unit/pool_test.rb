# == Schema Information
#
# Table name: pools
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tournament_id    :integer
#  min_units        :integer
#  name             :string(255)
#  published        :boolean
#  private          :boolean
#  nonadmin_invite  :boolean
#  require_approval :boolean
#  slug             :string(255)
#  q1               :string(255)
#  q1a              :string(255)
#  q2               :string(255)
#  q2a              :string(255)
#  q3               :string(255)
#  q3a              :string(255)
#  q4               :string(255)
#  q4a              :string(255)
#  q5               :string(255)
#  q5a              :string(255)
#

require 'test_helper'

class PoolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
