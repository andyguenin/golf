class Round < ActiveRecord::Base
  attr_accessible :h1, :h10, :h11, :h12, :h13, :h14, :h15, :h16, :h17, :h18, :h2, :h3, :h4, :h5, :h6, :h7, :h8, :h9, :round, :tplayer_id
  
  validates_presence_of :h1, :h2, :h3, :h4, :h5, :h6, :h7, :h8, :h9, :h10, :h11, :h12, :h13, :h14, :h15, :h16, :h17, :h18, :round, :tplayer
  
  belongs_to :tplayer
  
  def self.create_round(vec, round, tplayer)
    r = Round.new({:round => round, :tplayer_id => tplayer.id})
    r.update_scores(vec)
    r
  end
  
  def update_scores(vec)
    vec.length.times do |t|
      self["h#{t+1}".to_sym] = vec[t]
    end
    save!
  end
  
  def as_vec
    scores = []
    18.times do |t|
      scores << self["h#{t+1}".to_sym]
    end
    scores
  end
  
  def score_stats(other)
    a = as_vec
    18.times do |t|
      a[t] = a[t] - other[t] 
    end
    a.group_by{|p| p}.map {|k,v| {k =>v.length}}.reduce(:merge)
  end    
end
