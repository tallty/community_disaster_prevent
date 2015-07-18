# == Schema Information
#
# Table name: disasters
#
#  id                    :integer          not null, primary key
#  occur_time            :datetime
#  disaster_type         :string(255)
#  explain               :text(65535)
#  subscriber_id         :integer
#  disaster_positions_id :integer
#  disaster_picture_id   :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Disaster < ActiveRecord::Base
  belongs_to :subscriber
  has_many :disaster_pictures
  belongs_to :disaster_position
  
end
