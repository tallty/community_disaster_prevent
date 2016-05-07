# 五日天气预报
class ForecastServicesController < ApplicationController
	layout 'weixin'

  # 城市告警
  def city_warn
    @warnings = $redis.hvals("warnings_20000").map do |e|
      MultiJson.load(e)
    end
  end

  # 五日天气预报
  def five_day_weather
    # {周几 => [低温，高温，天气], ...}
		@weathers = FiveDayWeather.get_web_message

    # 实况天气
    subscriber = Subscriber.where(openid: params[:openid]).first
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
  	@index = WeatherIndex.get_web_message
  	# @index = {"体感指数" => ["2", "较适宜"], "穿衣指数" => ["2", "较适宜"], "洗晒指数" => ["2", "较适宜"], "户外晚间锻炼指数" => ["2", "较适宜"]}
  end

  # 空气质量
  def air_quality
    @results = Aqi.get_web_message
    # @result = { time: "2016-05-04 17:00", aqi: ["56-75", "70-90", "90-110"], level: ["良", "良", "差"], pripoll: ["PM2.5", "PM2.5", "O3"] }
  end

  # 健康气象
  def healthy_weather
    @results = Healthy.get_web_message
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
end