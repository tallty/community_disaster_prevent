# 预报服务
class ForecastServicesController < ApplicationController
  # before_action :invoke_wx_auth
  # before_action :get_wechat_sns, if: :is_wechat_brower?
	layout 'weixin'

  # 城市告警
  def city_warn
    @warnings = $redis.hvals("warnings_20000").map do |e|
      MultiJson.load(e)
    end
  end

  # 五日天气预报
  def five_day_weather
    five_day_weather = FiveDayWeather.new
    # {周几 => [低温，高温，天气], ...}
		@weathers = five_day_weather.get_web_message

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
    else
      # TODO 跳转绑定社区页面
      redirect_to centre_communities_path
    end

    # @weathers = {
    #   "2016-05-04" => ["8.2", "17.7", "多云"],
    #   "2016-05-05" => ["9", "21", "阴转多云"],
    #   "2016-05-06" => ["11", "22", "多云"],
    #   "2016-05-07" => ["13", "18", "阴转多云"],
    #   "2016-05-08" => ["13", "22", "多云"]
    # }
    # @auto_station = {"datetime" => "2015-10-27 14:20","name" => "体育场","sitenumber" => "98110","tempe" => "19.7","rain" => "0","wind_direction" => "347","wind_speed" => "6.6","visibility" => "10","humi" => "20","pressure" => "1024"}
  end

  # 生活指数
  def life_index
    weather_index = WeatherIndex.new
  	@index = weather_index.get_web_message
  	# @index = {"体感指数" => ["2", "较适宜"], "穿衣指数" => ["2", "较适宜"], "洗晒指数" => ["2", "较适宜"], "户外晚间锻炼指数" => ["2", "较适宜"]}
  end

  # 空气质量
  def air_quality
    aqi = AQI.new
    @result = aqi.get_web_message
    # @result = { time: "2016-05-04 17:00", aqi: ["56-75", "70-90", "90-110"], level: ["良", "良", "差"], pripoll: ["PM2.5", "PM2.5", "O3"] }
  end

  # 健康气象
  def healthy_weather
    healthy = Healthy.new
    @results = healthy.get_web_message
    # @results = {
    #   "儿童感冒气象风险" => {"今天" => ["4级", "建议"], "明天" => ["3级", "建议"]},
    #   "儿童哮喘气象风险" => {"今天" => ["4级", "建议"], "明天" => ["3级", "建议"]},
    #   "成人感冒气象风险" => {"今天" => ["4级", "建议"], "明天" => ["3级", "建议"]},
    #   "老人感冒气象风险" => {"今天" => ["4级", "建议"], "明天" => ["3级", "建议"]},
    #   "慢性阻塞性肺病气象风险" => {"今天" => ["4级", "建议"], "明天" => ["3级", "建议"]}
    # }
  end

  # 气象服务列表
  def index
    
  end

  private
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