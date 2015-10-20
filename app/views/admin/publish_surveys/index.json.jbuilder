json.array!(@publish_surveys) do |publish_survey|
  json.extract! publish_survey, :id
  json.url publish_survey_url(publish_survey, format: :json)
end
