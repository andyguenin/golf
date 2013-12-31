# == Schema Information
#
# Table name: pool_memberships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  pool_id    :integer
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  inviter_id :integer
#

class PoolMembership < ActiveRecord::Base
  attr_accessible :active, :pool_id, :user_id
  
  belongs_to :pool
  belongs_to :user
  has_many :picks, :dependent => :destroy
  belongs_to :inviter, class_name: "User"
  
  validates_presence_of :pool, :user
  validates_inclusion_of :active, :in => [true, false]
end
