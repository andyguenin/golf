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

class Course < ActiveRecord::Base
  attr_accessible :name, :tournament_id, :location

  validates_presence_of :name
  validates_presence_of :tournament_id
  validates_presence_of :location
  
  validates_uniqueness_of :name

  belongs_to :tournament
  has_many :holes, :order => "hole_number asc"
end
