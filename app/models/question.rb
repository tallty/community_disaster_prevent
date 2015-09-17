# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  q_title    :string(255)
#  q_type     :string(255)
#  q_digest   :string(255)
#  survey_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :options
  accepts_nested_attributes_for :options, allow_destroy: true, :reject_if => proc { |attributes| attributes['option_title'].blank? }  
end
