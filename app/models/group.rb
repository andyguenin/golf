class Group < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  validates_presence_of :slug

  def to_param
    self.slug
  end

  has_many :pools
  has_many :user_group_members
  has_many :users, :through => :user_group_members
  has_many :group_admins
  has_many :admins, :through => :group_admins, :source => :user
end
