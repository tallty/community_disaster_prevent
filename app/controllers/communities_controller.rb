# 微信端： 社区
class CommunitiesController < ApplicationController
  before_action :invoke_wx_auth
  before_action :get_wechat_sns, if: :is_wechat_brower?
	layout 'weixin'
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  before_action :set_article, only: [:show]
  respond_to :json, :html

	# 社区四个部分
	def interact
		@subscriber = Subscriber.where(openid: session[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
	end

  def detection
    # @subscriber = Subscriber.where(openid: params[:openid]).first
    # @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }

    # 实况天气
    subscriber = Subscriber.where(openid: session[:openid]).first
    if subscriber.present?
      # 用户所属社区
      @community = subscriber.community
      # 获取数据
      auto_station_info = MonitorStation.where(community: @community, station_type: "自动站").first
      auto_station_data = $redis.hget("monitor_stations", auto_station_info.station_number)
      # 气象实况
      @auto_station = MultiJson.load auto_station_data
      # 积水实况
      @water_stations = []
      @water_station_infos.each do |item|
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

     # 调用微信授权获取openid
    def invoke_wx_auth
      if params[:state].present? || !is_wechat_brower? \
        || session['openid'].present? || session[:user_id].present? 
        return # 防止进入死循环授权
      end
      # 生成授权url，再进行跳转
      sns_url =  $wechat_client.authorize_url(request.url)
      redirect_to sns_url and return
    end

    # 在invoke_wx_auth中做了跳转之后，此方法截取
    def get_wechat_sns
      # params[:state] 这个参数是微信特定参数，所以可以以此来判断授权成功后微信回调。
      if session[:openid].blank? && params[:state].present?
        sns_info = $wechat_client.get_oauth_access_token(params[:code])
        Rails.logger.debug("Weixin oauth2 response: #{sns_info.result}")
        # 重复使用相同一个code调用时：
        if sns_info.result["errcode"] != "40029"
          session[:openid] = sns_info.result["openid"]
        end
      end
    end
end