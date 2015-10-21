class PublishSurvey < ActiveRecord::Base
  has_one :survey
  has_one :community
  attr_accessor :district
  attr_accessor :street
  
  enum status: [ :closed, :used]

  def survey
    survey = Survey.where(id: self.survey_id).first
  end

  def community
    community = Community.where(id: self.community_id).first
  end
end
