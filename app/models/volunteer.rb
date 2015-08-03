# == Schema Information
#
# Table name: volunteers
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  tel           :string(255)
#  commun        :string(255)
#  neighborhood  :string(255)
#  subscriber_id :integer
#  community_id  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Volunteer < ActiveRecord::Base
  belongs_to :subscriber
  validates :name, :tel, :commun, :neighborhood, presence: true
end
