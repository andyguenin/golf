# == Schema Information
#
# Table name: scrapers
#
#  id         :integer          not null, primary key
#  label      :string(255)
#  url        :string(255)
#  post_to    :string(255)
#  frequency  :integer
#  starttime  :datetime
#  endtime    :datetime
#  user_id    :integer
#  pause      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Scraper < ActiveRecord::Base
  attr_accessible :endtime, :frequency, :label, :pause, :post_to, :starttime, :url, :user_id
  
  belongs_to :user
end
