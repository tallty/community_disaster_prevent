# 五日天气预报
class ForecastServicesController < ApplicationController
	layout 'weixin'

  def city_warn

  end

  def five_day_weather
    # {周几 => [低温，高温，天气], ...}
		# @weathers = FiveDayWeather.get_web_message
		@weathers = {
			"4" => ["11", "16", "阴转多云"],
			"5" => ["13", "17", "阴转多云"],
			"6" => ["15", "19", "阴转多云"],
			"0" => ["12", "14", "阴转多云"],
			"1" => ["9", "12", "阴转多云"]
		}
  end

  def life_index
  	# @index = WeatherIndex.get_web_message
  	@index = {"体感指数" => ["2级", "较适宜"], "穿衣指数" => ["2级", "较适宜"], "洗晒指数" => ["2级", "较适宜"], "户外晚间锻炼指数" => ["2级", "较适宜"]}
  end

  def air_quality

  end

  def healthy_weather
  	@index = {"体感指数" => ["2级", "较适宜"], "穿衣指数" => ["2级", "较适宜"], "洗晒指数" => ["2级", "较适宜"], "户外晚间锻炼指数" => ["2级", "较适宜"]}

  end
end