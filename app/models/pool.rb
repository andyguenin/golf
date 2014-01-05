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
#

class Pool < ActiveRecord::Base
  attr_accessor :q1, :q1a, :q2, :q2a, :q3, :q3a, :q4, :q4a, :q5, :q5a, :t_id
  attr_accessible :tournament_id, :q1, :q1a, :q2, :q2a, :q3, :q3a, :q4, :q4a, :q5, :q5a, :name, :private, :nonadmin_invite

  belongs_to :tournament
  has_many :q_answers
  has_many :pool_memberships, :conditions => {:active => true}
  has_many :picks, :through => :pool_memberships
  has_many :users, :through => :pool_memberships
  has_many :admin_members, class_name: "PoolMembership", :conditions => {:admin => true}
  has_many :admins, :through => :admin_members, :source => :user
  has_many :non_admin_members, class_name: "PoolMembership", :conditions => {:admin => false}
  has_many :non_admins, :through => :non_admin_members, :source => :user

  validates_presence_of :tournament_id
  validates_inclusion_of :private, :in => [true, false]

  after_initialize :default_values


  (1..5).each do |t|

    define_method("q#{t}") do 
      ans = q_answers.find_by_number(t)
      unless ans.nil?
        ans.question
      end
    end

    define_method("q#{t}=") do |q|
      ans = q_answers.find_by_number(t)
      if ans.nil?
        q_answers.create({:question => q, :number => t})
      else
        ans.update_attribute(:question, q)
      end
    end

    define_method("q#{t}a") do 
      ans = q_answers.find_by_number(t)
      unless ans.nil?
        ans.answer
      end
    end

    define_method("q#{t}a=") do |q|
      ans = q_answers.find_by_number(t)
      unless ans.nil?
        if(q == "on")
          q = nil
        end
        ans.update_attribute(:answer, q)
      end
    end
  end

  def default_values
    self.private ||= false
    self.name ||= self.tournament.name if self.tournament
  end
  
#  def is_user_admin(user)
    

end
