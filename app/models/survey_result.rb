# == Schema Information
#
# Table name: survey_results
#
#  id            :integer          not null, primary key
#  q_result      :string(255)
#  survey_id     :integer
#  subscriber_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SurveyResult < ActiveRecord::Base
  belongs_to :survey
  belongs_to :subscriber
end
