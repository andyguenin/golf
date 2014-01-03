# == Schema Information
#
# Table name: holes
#
#  id          :integer          not null, primary key
#  course_id   :integer
#  hole_number :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  par         :integer
#


require 'test_helper'

class HoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
