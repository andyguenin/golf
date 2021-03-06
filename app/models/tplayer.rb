# == Schema Information
#
# Table name: tplayers
#
#  id            :integer          not null, primary key
#  player_id     :integer
#  tournament_id :integer
#  bucket        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  score         :integer
#  status        :integer
#  deagle        :integer
#  eagle         :integer
#  birdie        :integer
#  par           :integer
#  bogey         :integer
#  dbogey        :integer
#  tbogey        :integer
#  current_round :integer
#  rank          :integer
#  r1_bonus      :integer
#  r2_bonus      :integer
#  r3_bonus      :integer
#  r4_bonus      :integer
#  a             :boolean
#  x             :boolean
#

class Tplayer< ActiveRecord::Base
  attr_accessible :bucket, :player_id, :tournament, :score, :status, :deagle, :eagle, :birdie, :par, :bogey, :dbogey, :tbogey, :rank

  #status: 0> won 1>playing/finished 2> mdf 3> cut 4> wd 5> dq 6> did not start 
  validates :bucket, :inclusion => 0..5
  validates_presence_of :player_id
  validates_presence_of :tournament_id
  validates_presence_of :score
  validates_presence_of :status
  validates_presence_of :deagle, :eagle, :birdie, :par, :bogey, :dbogey, :tbogey


  after_initialize :set_default
  
  def set_default
    [:deagle, :eagle, :birdie, :par, :bogey, :dbogey, :tbogey].each do |t|
      self[t] ||= 0
    end
  end

  belongs_to :tournament
  belongs_to :player
  has_many :rounds, :order => "round asc"
  has_many :player_premia

  def name_and_labels
    player.name + (self.a ? " [A]" : "") + (self.x ? " [EX]" : "")
  end
  
  def hole
    if rounds.size != 0
      18
    else
      1
    end
  end

  def scores
    if self.id.nil?
      [[[]]]
    else
      a = player.scores_by_tournament(tournament).reverse
      a.drop(a.size < 4 ? 0 : a.size - 4).map do |s|
        s.zip(tournament.pars)
      end.reverse
    end
  end


  def round
    rounds.size
  end

  def get_round(r)
    rounds.where("round = ?", r).first
  end
  
  def score_through(r)
    scores.slice(0,r).map{|r| r.map{|t| t.length == 2 and t[0] != 0 ? t[0] - t[1] : 0}.sum}.sum
  end
  
  def completed_rounds
    a = scores
    a.length > 0 ? a.length - (a.last.map{|p| p[0]}.select{|p| p!= 0}.count < 18 ? 1 : 0) : 0
  end

  def update_score(status)
    sc = scores.flatten(1).select do |h| 
      h[0] != 0
    end
    upd_status = 1
    begin 
      a = Integer(status)
    rescue ArgumentError, TypeError
      
      unless a.to_s == score
        unless status == "F"
          if status == "WD" or status == "N/A"
            upd_status = 4
          elsif status == "CUT"
            upd_status = 3
          elsif status == "MDF"
            upd_status = 2
          elsif status == "SS"
            upd_status = 6
          elsif status == "DQ"
            upd_status = 5
          else
            unless sc.length > 0
              upd_status = 6
            end
          end
        end
      end
    end
    
            
    score_type = scores.flatten(1).select{|t| t[0] != 0}.map{|r| [[0,r[0] - r[1] + 2].max,4].min}
    stats=[0,0,0,0,0]
    score_type.length.times do |t|
      stats[score_type[t]] = stats[score_type[t]]+1
    end
    self.update_attributes!({
                              :status => upd_status,
                              :score => sc.map{|t| t.length == 2 ? t[0] - t[1] : 0}.sum,
                              :deagle => stats[0],
                              :eagle => stats[0],
                              :birdie => stats[1],
                              :par => stats[2],
                              :bogey => stats[3],
                              :dbogey => stats[4],
                              :tbogey => stats[4]
                              })
      
  end

  def get_premium_by_pool(pool)
    p = player_premia.where("pool_id = ?", pool.id)
    if p.empty?
      p.new({:pool_id => pool.id})
    else
      p[0]
    end
  end
  
end
