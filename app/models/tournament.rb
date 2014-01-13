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
  
  def rank_players
    cur_place = 1
    score_freq = self.tplayers.where("status <= 1").count(:group => :score)
    score_freq.keys.sort.each do |score|
      freq = score_freq[score]
      self.tplayers.where("score = ?", score).each do |t|
        place = (freq != 1 && cur_place == 1) ? "T#{cur_place}" : "#{cur_place}"
        t.update_attribute(:rank, place)
      end
      cur_place = cur_place + freq
    end
  end  
end
