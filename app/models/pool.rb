class Pool < ActiveRecord::Base
  attr_accessor :q1, :q1a, :q2, :q2a, :q3, :q3a, :q4, :q4a, :q5, :q5a, :t_id
  attr_accessible :tournament_id, :q1, :q1a, :q2, :q2a, :q3, :q3a, :q4, :q4a, :q5, :q5a, :name

  belongs_to :group
  belongs_to :tournament
  has_many :q_answers
  has_many :golfpicks

  validates_presence_of :group_id
  validates_presence_of :tournament_id

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
        q_answers.create({:question => q})
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

end
