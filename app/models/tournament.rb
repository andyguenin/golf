# == Schema Information
#
# Table name: tournaments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  starttime  :datetime
#  endtime    :datetime
#  slug       :string(255)
#  round      :integer
#  low_score  :integer
#  locked     :boolean
#  tiebreak   :integer
#

class Tournament < ActiveRecord::Base
  attr_accessible :endtime, :name, :starttime

  
  def to_param
    self.slug
  end

  has_many :pools
  has_many :scores
  has_many :player_score_statuses
  has_one :course
  has_many :tplayers
  has_many :players, :through => :tplayers
  has_many :picks, :through => :pools
  
  def formatted_start
    self.starttime.strftime("%A, %B %d, %Y")
  end
  
  def formatted_end
    self.endtime.strftime("%A, %B %d, %Y")
  end

  def formatted_time
    self.starttime.in_time_zone("Eastern Time (US & Canada)").strftime("%k:%M %Z")
  end
  
  def rank_players
    cur_place = 1
    score_freq = self.tplayers.where("status <= 1").count(:group => :score)
    score_freq.keys.sort.each do |score|
      freq = score_freq[score]
      self.tplayers.where("score = ?", score).each do |t|
        place = (freq != 1 && cur_place == 1 && t.status == 0) ? (cur_place = cur_place + 1; 1) : cur_place
        t.update_attribute(:rank, place)
      end
      cur_place = cur_place + freq
    end
  end  

  def auto_bucket
    null_ranked = players.where("pga_rank is NULL")
    null_ranked.each do |p|
      p.update_attribute(:pga_rank, 10000)
    end
    all_p = players.order("pga_rank asc")
    division = (all_p.count-8)/4
    all_p.size.times do |t|
      bucket = 5
      if t < 8
        bucket = 1
      else
        bucket = [5,((t-8)/division).to_i + 2].min
      end        
      all_p[t].get_tplayer(self).update_attribute(:bucket, bucket)
    end
  end

  def pars
    self.course.holes.map{|h| h.par}
  end
end
