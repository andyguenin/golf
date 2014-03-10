# == Schema Information
#
# Table name: rounds
#
#  id         :integer          not null, primary key
#  tplayer_id :integer
#  round      :integer
#  h1         :integer
#  h2         :integer
#  h3         :integer
#  h4         :integer
#  h5         :integer
#  h6         :integer
#  h7         :integer
#  h8         :integer
#  h9         :integer
#  h10        :integer
#  h11        :integer
#  h12        :integer
#  h13        :integer
#  h14        :integer
#  h15        :integer
#  h16        :integer
#  h17        :integer
#  h18        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Round < ActiveRecord::Base
  attr_accessible :h1, :h10, :h11, :h12, :h13, :h14, :h15, :h16, :h17, :h18, :h2, :h3, :h4, :h5, :h6, :h7, :h8, :h9, :round, :tplayer_id
  
  validates_presence_of :h1, :h2, :h3, :h4, :h5, :h6, :h7, :h8, :h9, :h10, :h11, :h12, :h13, :h14, :h15, :h16, :h17, :h18, :round, :tplayer
  
  belongs_to :tplayer
  
  def self.create_round(vec, round, tplayer)
    r = Round.new({:round => round, :tplayer_id => tplayer.id})
    18.times do |t|
      r["h#{t+1}".to_sym] = 0
    end
    r.update_strokes(vec)
    r.save!
    r
  end
  
  def update_strokes(vec)
    changed = false
    18.times do |t|
      c_score = self["h#{t+1}".to_sym]
      if vec[t].to_i != c_score
        self["h#{t+1}".to_sym] = vec[t].to_i
        changed = true
      end
    end
    save! if changed
  end
  
  def as_vec
    scores = []
    18.times do |t|
      scores << self["h#{t+1}".to_sym]
    end
    scores
  end
  
  def score_stats
    pars = tplayer.tournament.course.holes.map{|h| h.par}
    stats = [0,0,0,0,0]
    a = as_vec
    18.times do |t|
      if a[t] != 0
        s = a[t] - pars[t]
        s = [[-2, s].max, 2].min + 2
        stats[s] = stats[s] + 1
      end
    end
    stats
  end 


end
