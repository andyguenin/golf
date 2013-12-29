# == Schema Information
#
# Table name: nonmember_invitees
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  pool_id    :integer
#  inviter_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class NonmemberInviteesTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
