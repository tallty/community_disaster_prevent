# 微信端： 社区
class CommunitiesController < ApplicationController
	layout 'weixin'
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  before_action :set_article, only: [:show]
  before_action :set_subscriber
  respond_to :json, :html

	# 社区四个部分
	def interact
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
	end

  # 实况监测
  def detection
    # 用户所属社区
    @community = @subscriber.community
    if @community.present?
      # 社区预警
      code = @community.code
      # 气象实况
      @auto_station = MonitorStation::CommunityAutoStation.new.fetch code
      # @water_stations = MonitorStation.community_water_data code
      # 社区预警
      @warning = Warning.get_last_active_warn code
    else
      # 跳转绑定社区页面
      redirect_to centre_communities_path
    end
  end

  def community_risk
    @articles = ArticleManager.where(keyword: '社区风险', community: @subscriber.community)
    # @articles = Article.all
  end

  def change_community
    @communities = Community.all
  end

  def centre
    
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def set_subscriber
      # @subscriber = Subscriber.first
      @subscriber = Subscriber.where(openid: session[:openid]).first
    end
end
