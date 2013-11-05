# == Schema Information
#
# Table name: tournaments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  starttime  :datetime
#  endtime    :datetime
#  slug       :string(255)
#  round      :integer
#  low_score  :integer
#  locked     :boolean
#

require 'test_helper'

class TournamentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
