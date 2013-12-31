# == Schema Information
#
# Table name: pools
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  tournament_id   :integer
#  min_units       :integer
#  name            :string(255)
#  published       :boolean
#  private         :boolean
#  nonadmin_invite :boolean
#

class Pool < ActiveRecord::Base
  attr_accessor :q1, :q1a, :q2, :q2a, :q3, :q3a, :q4, :q4a, :q5, :q5a, :t_id
  attr_accessible :tournament_id, :q1, :q1a, :q2, :q2a, :q3, :q3a, :q4, :q4a, :q5, :q5a, :name, :private, :nonadmin_invite

  belongs_to :tournament
  has_many :q_answers
  has_many :pool_memberships
  has_many :picks, :through => :pool_memberships

  validates_presence_of :tournament_id
  validates_presence_of :private

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
