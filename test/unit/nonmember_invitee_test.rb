# == Schema Information
#
# Table name: nonmember_invitees
#
#  id             :integer          not null, primary key
#  pool_id        :integer
#  inviter_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  activation_key :string(255)
#  user_id        :integer
#

require 'test_helper'

class NonmemberInviteeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
