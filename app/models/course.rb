class Course < ActiveRecord::Base
  attr_accessible :name, :tournament_id

  validates_presence_of :name
  validates_presence_of :tournament_id

  belongs_to :tournament
  has_many :holes
end
