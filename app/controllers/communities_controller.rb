# 微信端： 社区
class CommunitiesController < ApplicationController
	layout 'weixin'
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  before_action :set_article, only: [:show]
  before_action :set_subscriber
  respond_to :json, :html

	# 社区四个部分
	def interact
		@subscriber = Subscriber.where(openid: session[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
	end

  def detection
    # 实况天气
    subscriber = Subscriber.where(openid: session[:openid]).first
    if subscriber.present?
      # 用户所属社区
      @community = subscriber.community
      # 获取数据
      auto_station_info = MonitorStation.where(community: @community, station_type: "自动站").first
      water_station_infos = MonitorStation.where(community: @community, station_type: "积水站")
      auto_station_data = $redis.hget("monitor_stations", auto_station_info.station_number)
      # 气象实况
      @auto_station = MultiJson.load auto_station_data
      # 积水实况
      @water_stations = []
      water_station_infos.each do |item|
        data = MultiJson.load($redis.hget("monitor_stations", item.station_number)) rescue {}
        if data.present?
          @water_stations << data
        end
      end
    else
      # TODO 跳转绑定社区页面
      redirect_to centre_communities_path
    end
  end

  def community_risk
    @articles = Article.all
  end

  def change_community
    @communities = Community.all
  end

  def centre
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_subscriber
      @subscriber = Subscriber.where(openid: session[:openid]).first
    end
end