# == Schema Information
#
# Table name: pools
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tournament_id    :integer
#  min_units        :integer
#  name             :string(255)
#  published        :boolean
#  private          :boolean
#  nonadmin_invite  :boolean
#  require_approval :boolean
#  slug             :string(255)
#  q_answer_id1     :integer
#  q_answer_id2     :integer
#  q_answer_id3     :integer
#  q_answer_id4     :integer
#  q_answer_id5     :integer
#  q1               :string(255)
#  q2               :string(255)
#  q3               :string(255)
#  q4               :string(255)
#  q5               :string(255)
#  q1a              :boolean
#  q2a              :boolean
#  q3a              :boolean
#  q4a              :boolean
#  q5a              :boolean
#

class Pool < ActiveRecord::Base
  attr_accessor :t_id
  attr_accessible :tournament_id, :name, :private, :nonadmin_invite, :q1, :q1a, :q2, :q2a, :q3, :q3a, :q4, :q4a, :q5, :q5a

  belongs_to :tournament
  has_many :pool_memberships, :conditions => {:active => true}
  has_many :inactive_memberships, class_name: "PoolMembership", :conditions => {:active => false}
  has_many :picks, :through => :pool_memberships, :conditions => {:approved => true}
  has_many :pending_picks, :through => :pool_memberships, :source => :picks,  :conditions => {:approved => false}
  has_many :all_picks, :through => :pool_memberships, :source => :picks
  has_many :users, :through => :pool_memberships
  has_many :admin_members, class_name: "PoolMembership", :conditions => {:admin => true}
  has_many :admins, :through => :admin_members, :source => :user
  has_many :non_admin_members, class_name: "PoolMembership", :conditions => {:admin => false}
  has_many :non_admins, :through => :non_admin_members, :source => :user

  validates_presence_of :tournament_id, :q1, :q2, :q3, :q4, :q5
  validates_inclusion_of :private, :in => [true, false]
  validate :validate_slug

  before_validation :create_slug
  after_initialize :default_values


  def to_param
    self.slug
  end


  def default_values
    self.private ||= false
    self.name ||= self.tournament.name if self.tournament
  end

  def user_join(user)
    pms = inactive_memberships.where("user_id = ?", user.id)
    if pms.empty?
      pm = PoolMembership.new({:user => user, :pool_id => self.id, :active => true})
      pm.save!
    else
      pms[0].update_attribute(:active, true)
    end    
  end
  
  def q_answers
    [[q1,q1a], [q2,q2a], [q3,q3a], [q4,q4a], [q5,q5a]]
  end
  
  def create_slug
    if not self.name.nil?
      self.slug = self.name.downcase.gsub(/[^a-z0-9\s]/,'').gsub(" ","-") + "-" + tournament.starttime.strftime("%d%m%Y")
    end
  end

  def validate_slug
    p = Pool.find_by_slug(slug)
    if not p.nil? and p.id != self.id
      errors.add(:name, "has alread been taken")
    end
  end

#  def is_user_admin(user)
    

end
