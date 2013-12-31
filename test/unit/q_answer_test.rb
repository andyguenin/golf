# == Schema Information
#
# Table name: q_answers
#
#  id         :integer          not null, primary key
#  pool_id    :integer
#  answer     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  question   :string(255)
#  number     :integer
#

require 'test_helper'

class QAnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
