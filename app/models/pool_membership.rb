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
#  admin      :boolean
#  creator    :boolean
#

class PoolMembership < ActiveRecord::Base
  attr_accessible :active, :pool_id, :user_id, :inviter_id, :user, :creator
  
  belongs_to :pool
  belongs_to :user
  has_many :picks, :dependent => :destroy
  belongs_to :inviter, class_name: "User"
  
  validates_presence_of :pool, :user
  validates_inclusion_of :active, :in => [true, false]
  validates_inclusion_of :admin, :in => [true, false]
  validates_uniqueness_of :pool_id, scope: [:user_id]
  
  after_initialize do
    self.admin ||= false
  end
end
