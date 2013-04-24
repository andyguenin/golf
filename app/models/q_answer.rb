class QAnswer < ActiveRecord::Base
  attr_accessible :answer, :pool_id, :number, :question

  has_one :pool
end
