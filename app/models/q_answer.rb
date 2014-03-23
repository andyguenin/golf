# == Schema Information
#
# Table name: q_answers
#
#  id         :integer          not null, primary key
#  answer     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  question   :string(255)
#  number     :integer
#

class QAnswer < ActiveRecord::Base
  attr_accessible :answer, :number, :question
end
