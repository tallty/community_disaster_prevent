class SurveysController < ApplicationController
  before_action :set_survey, only: [:show]
  layout 'weixin'
  
  def show
    @subscriber = Subscriber.where(openid: params[:openid]).first
  end

  def update
    survey = Survey.where(id: params[:id]).first
    subscriber = Subscriber.where(openid: params[:openid]).first
    params["q"]["result"].map do |i, e|
      result = SurveyResult.find_or_create_by(survey: survey, subscriber: subscriber, q_index: i)
      result.q_result = e
      result.save
    end
    render :text => "谢谢"
  end

  private
  def set_survey
    @survey = Survey.find(params[:id])
  end
end
