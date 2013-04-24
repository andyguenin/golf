class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_many :golfpicks
  has_many :user_group_members
  has_many :groups, :through => :user_group_members

  has_many :group_admins
  has_many :admingroups, :through =>:group_admins, :source => :user

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def update_name

    self.update_attribute(:name, "a" + self.name)
  end
  
  handle_asynchronously :update_name, :run_at => Proc.new { 5.seconds.from_now }

end
