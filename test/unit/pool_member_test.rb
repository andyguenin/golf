# == Schema Information
#
# Table name: pool_members
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  pool_id    :integer
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  inviter_id :integer
#

require 'test_helper'

class PoolMemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
