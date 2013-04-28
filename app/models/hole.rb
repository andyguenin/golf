class Hole < ActiveRecord::Base
  attr_accessible :course_id, :hole_number, :par

  validates_presence_of :course_id
  validates_presence_of :hole_number
  validates_presence_of :par

  belongs_to :course
  has_many :scores
end
