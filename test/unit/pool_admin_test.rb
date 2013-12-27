# == Schema Information
#
# Table name: pool_admins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  pool_id    :integer
#  creator    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PoolAdminTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
