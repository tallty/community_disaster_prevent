# 微信端： 社区
class CommunitiesController < ApplicationController
	layout 'weixin'

	# 社区四个部分
	def index
		@subscriber = Subscriber.where(openid: params[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
	end
end