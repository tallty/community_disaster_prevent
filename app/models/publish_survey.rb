class PublishSurvey < ActiveRecord::Base
  has_one :survey
  has_one :community
  attr_accessor :street
  
  enum status: [ :closed, :used]
end
