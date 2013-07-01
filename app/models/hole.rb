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

class Hole < ActiveRecord::Base
  attr_accessible :course_id, :hole_number, :par

  validates_presence_of :course_id
  validates_presence_of :hole_number
  validates_presence_of :par

  belongs_to :course
  has_many :scores
end
