# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  admin         :boolean
#  role          :integer
#  active        :boolean
#  username      :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :active, :name
  
  has_many :pool_memberships, :conditions => {:active => true}
  has_many :all_pool_memberships, class_name: "PoolMembership", :dependent => :destroy
  has_many :pools, :through => :pool_memberships
  has_many :all_pools, :through => :all_pool_memberships, source: "pool"
  has_many :picks, :through => :pool_memberships, :dependent => :destroy
  has_many :invites, class_name: "NonmemberInvitee", :dependent => :destroy
  
  attr_accessor :password
  before_save :encrypt_password


  validate :ensure_static_username
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create, :if => :active?
  validate :check_password, :on => :update
  validates_presence_of :email
  validates_presence_of :name, :if => :active?
  validates_uniqueness_of :email, :username
  
  def to_param
    self.username
  end

  def ensure_static_username
    if not self.id.nil?
      if self.username != self.username_was
        self.errors.add(:username, "cannot be changed")
      end
    end      
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) && user.active?
      user
    else
      unless user.nil? or user.active
        user.errors.add(:email, "has been registered, but not activated. Please check your email and click on the confirmation link")
      end
      nil
    end
  end

  def get_picks_by_tournament(t)
    picks.includes(:pool_membership => :pool).where("pools.tournament_id = ?", t.id)
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  private
  
  def check_password
    if self.password_hash.nil? and self.password.empty?
      errors.add(:password, "can't be blank")
    end
  end
end
