# == Schema Information
#
# Table name: surveys
#
#  id           :integer          not null, primary key
#  s_title      :string(255)
#  s_digest     :string(255)
#  s_author     :string(255)
#  community_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Survey < ActiveRecord::Base
  has_many :questions
  belongs_to :publish_survey
  accepts_nested_attributes_for :questions, allow_destroy: true, :reject_if => lambda { |a| a[:q_title].blank? }
  
  validates_presence_of :s_title
end
