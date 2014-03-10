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
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :active, :name
  
  has_many :pool_memberships, :conditions => {:active => true}
  has_many :all_pool_memberships, class_name: "PoolMembership"
  has_many :pools, :through => :pool_memberships
  has_many :all_pools, :through => :all_pool_memberships, source: "pool"
  has_many :picks, :through => :pool_memberships
  
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create, :if => :active?
  validate :check_password, :on => :update
  validates_presence_of :email
  validates_presence_of :name, :if => :active?
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) && user.active?
      user
    else
      unless user.active?
        user.errors.add(:email, "has been registered, but not activated. Please check your email and click on the confirmation link")
      end
      nil
    end
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
