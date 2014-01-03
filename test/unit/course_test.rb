# == Schema Information
#
# Table name: courses
#
#  id            :integer          not null, primary key
#  tournament_id :integer
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  location      :string(255)
#


require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
