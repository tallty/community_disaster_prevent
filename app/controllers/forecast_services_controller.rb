# 预报服务
class ForecastServicesController < ApplicationController
	layout 'weixin'
  before_action :get_city_warn, only: [:city_warn, :five_day_weather]

  # 城市告警
  def city_warn
  end

  # 五日天气预报
  def five_day_weather
    # subscriber = Subscriber.where(openid: session[:openid]).first
    # @community = subscriber.community
    @community = Community.second
    
    # 五日预报
    five_day_weather = FiveDayWeather.new
		@weathers = five_day_weather.get_web_message

    # 全市预警
    @warn = Warning.get_last_active_warn 20000

    # 气象实况
    if @community.present?
      @auto_station = MonitorStation.community_weather_data @community
    else
      redirect_to centre_communities_path
    end
  end

  # 生活指数
  def life_index
    weather_index = WeatherIndex.new
  	@index, _publishtime = weather_index.get_web_message
    @publish_time = DateTime.parse(_publishtime)
  end

  # 空气质量
  def air_quality
    aqi = AQI.new
    # 今明空气质量
    @result = aqi.get_web_message
    # 过去24小时空气质量
    @aqi_weathers = AQI.get_history_by_city("上海").reverse
    # 发布时间
    
    # # 整理获取AQI图表需要的相应数据
    @aqi_datas, @pm25_datas, @pm10_datas, @o3_datas, @no2_datas = AQI.organize_aqi_datas @aqi_weathers
  end

  # 健康气象
  def healthy_weather
    @results = Healthy::HealthyData.new.get_web_message
    @publish_time = Time.zone.now
  end

  # 气象服务列表
  def index
    session[:openid] = params[:openid]
  end

  private
    def get_city_warn
      @warnings = $redis.hvals("warnings_20000").map do |e|
        MultiJson.load(e)
      end
    end

end
