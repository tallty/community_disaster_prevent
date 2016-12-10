# 预报服务
class ForecastServicesController < ApplicationController
	layout 'weixin'
  before_action :get_city_warn, only: [:city_warn, :five_day_weather]

  # 城市告警
  def city_warn
    @city_warnings = Warning::CityWarningProcess.new.fetch
  end

  def locate
    
  end

  # 五日天气预报
  def five_day_weather
    result = LocationUtil.new.reverse(location_params)
    # 街道
    # @district = result['addressComponent']['district']
    # # 五日预报
    # @weathers = Weather::FiveDayWeather.new.fetch
    # # 全市预警
    # @warn = Warning::CityWarningProcess.new.fetch
    # # 气象实况
    # @auto_station = Weather::DistrictWeather.new.fetch @district
  end

  # 生活指数
  def life_index
  	@index, _publishtime = WeatherIndex::WeatherIndexData.new.get_web_message
    @publish_time = DateTime.parse(_publishtime)
  end

  # 空气质量
  def air_quality
    # 今明空气质量
    @result = AQI::AqiData.new.get_web_message
    # 过去24小时空气质量
    # @aqi_weathers = AQI.get_history_by_city("上海").reverse
    # 发布时间
    # # 整理获取AQI图表需要的相应数据
    # @aqi_datas, @pm25_datas, @pm10_datas, @o3_datas, @no2_datas = AQI.organize_aqi_datas @aqi_weathers
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

  def location_params
    params.permit(:lon, :lat)
  end
end
