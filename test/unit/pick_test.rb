<<<<<<< HEAD
# == Schema Information
#
# Table name: picks
#
#  id                 :integer          not null, primary key
#  pool_membership_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  p1                 :integer
#  p2                 :integer
#  p3                 :integer
#  p4                 :integer
#  p5                 :integer
#  q1                 :boolean
#  q2                 :boolean
#  q3                 :boolean
#  q4                 :boolean
#  q5                 :boolean
#  tiebreak           :integer
#  score              :integer
#

require 'test_helper'

class PickTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
=======
# == Schema Information
#
# Table name: picks
#
#  id                 :integer          not null, primary key
#  pool_membership_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  p1                 :integer
#  p2                 :integer
#  p3                 :integer
#  p4                 :integer
#  p5                 :integer
#  q1                 :boolean
#  q2                 :boolean
#  q3                 :boolean
#  q4                 :boolean
#  q5                 :boolean
#  tiebreak           :integer
#

require 'test_helper'

class PickTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
>>>>>>> 862abcc2281186d7fcae420d3c3f34388a4f5c0a
