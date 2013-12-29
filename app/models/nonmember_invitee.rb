# == Schema Information
#
# Table name: nonmember_invitees
#
#  id             :integer          not null, primary key
#  pool_id        :integer
#  inviter_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  activation_key :string(255)
#  user_id        :integer
#

class NonmemberInvitee < ActiveRecord::Base
  attr_accessible :user_id, :inviter_id, :pool_id, :activation_key
  
  belongs_to :inviter, class_name: "User"
  belongs_to :pool
  belongs_to :user
  
  validates_presence_of :inviter, :pool, :user, :activation_key
end
