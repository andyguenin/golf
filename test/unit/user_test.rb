# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string(255)
#  email                        :string(255)
#  password_hash                :string(255)
#  password_salt                :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  admin                        :boolean
#  role                         :integer
#  active                       :boolean
#  username                     :string(255)
#  forgot_password              :string(255)
#  consec_failed_login_attempts :integer
#  locked                       :boolean
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

