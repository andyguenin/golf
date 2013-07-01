# == Schema Information
#
# Table name: options
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Options < ActiveRecord::Base
  attr_accessible :key, :value
end
