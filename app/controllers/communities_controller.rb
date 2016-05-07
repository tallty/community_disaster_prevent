# 微信端： 社区
class CommunitiesController < ApplicationController
	layout 'weixin'
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  respond_to :json, :html

	# 社区四个部分
	def interact
		@subscriber = Subscriber.where(openid: params[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
	end

  def detection
    @subscriber = Subscriber.where(openid: params[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
  end

  def community_risk
    @subscriber = Subscriber.where(openid: params[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
  end

  def change_community
    @communities = Community.all
  end

  def centre
    # @community = Community.new(community_params)
    #   @community.code = Community.where(district: "杨浦").last.code.succ

    #   respond_to do |format|
    #     if @community.save
    #       format.html { redirect_to admin_communities_path }
    #       format.json { render :show, status: :created, location: @community }
    #     else
    #       format.html { render :new }
    #       format.json { render json: @community.errors, status: :unprocessable_entity }
    #     end
    #   end
  end
end