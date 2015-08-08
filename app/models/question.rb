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
  has_many :options
end
