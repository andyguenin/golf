class Pool < ActiveRecord::Base
  belongs_to :group
  belongs_to :tournament
  has_many :golfpicks

  validates_presence_of :group_id
  validates_presence_of :tournament_id

end
