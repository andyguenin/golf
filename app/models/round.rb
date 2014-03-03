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
    changed = false
    vec.length.times do |t|
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

  def self.stats_combiner(s1, s2)
    stats = []
    s1.length.times do |t|
      stats << s1[t] + s2[t]
    end
    stats
  end     

end
