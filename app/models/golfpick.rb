class Golfpick < ActiveRecord::Base
  belongs_to :user
  belongs_to :pool

  belongs_to :pick1, :class_name => "Player", :foreign_key => "pick1"
  belongs_to :pick2, :class_name => "Player", :foreign_key => "pick2"
  belongs_to :pick3, :class_name => "Player", :foreign_key => "pick3"
  belongs_to :pick4, :class_name => "Player", :foreign_key => "pick4"
  belongs_to :pick5, :class_name => "Player", :foreign_key => "pick5"

  attr_accessible :pick1, :pick2, :pick3, :pick4, :pick5, :q1, :q2, :q3, :q4, :q5, :tiebreak, :user_id, :score, :bonus


end
