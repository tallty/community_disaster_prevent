# 五日天气预报
class ForecastServicesController < ApplicationController
	layout 'weixin'

  # 城市告警
  def city_warn

  end

  # 五日天气预报
  def five_day_weather
    # {周几 => [低温，高温，天气], ...}
		# @weathers = FiveDayWeather.get_web_message
		@weathers = {
			"2016-05-04" => ["8.2", "17.7", "多云"],
			"2016-05-05" => ["9", "21", "阴转多云"],
			"2016-05-06" => ["11", "22", "多云"],
			"2016-05-07" => ["13", "18", "阴转多云"],
			"2016-05-08" => ["13", "22", "多云"]
		}
  end

  # 生活指数
  def life_index
  	# @index = WeatherIndex.get_web_message
  	@index = {"体感指数" => ["2", "较适宜"], "穿衣指数" => ["2", "较适宜"], "洗晒指数" => ["2", "较适宜"], "户外晚间锻炼指数" => ["2", "较适宜"]}
  end

  # 空气质量
  def air_quality
    # @results = Aqi.get_web_message
    @result = { time: "2016-05-04 17:00", aqi: ["56-75", "70-90", "90-110"], level: ["良", "良", "差"], pripoll: ["PM2.5", "PM2.5", "O3"] }
  end

  # 健康气象
  def healthy_weather
    # @results = Healthy.get_web_message
    @results = {
      "儿童感冒气象风险" => {"今天" => ["4级", "建议"], "明天" => ["3级", "建议"]},
      "儿童哮喘气象风险" => {"今天" => ["4级", "建议"], "明天" => ["3级", "建议"]},
      "成人感冒气象风险" => {"今天" => ["4级", "建议"], "明天" => ["3级", "建议"]},
      "老人感冒气象风险" => {"今天" => ["4级", "建议"], "明天" => ["3级", "建议"]},
      "慢性阻塞性肺病气象风险" => {"今天" => ["4级", "建议"], "明天" => ["3级", "建议"]}
    }
  end
end