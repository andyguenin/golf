# == Schema Information
#
# Table name: pool_admins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  pool_id    :integer
#  creator    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PoolAdmin < ActiveRecord::Base
  attr_accessible :creator, :pool_id, :user_id
end
