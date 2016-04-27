# 五日天气预报
class ForecastServicesController < ApplicationController
	layout 'weixin'

  def city_warn

  end

  def five_day_weather
		# cache = FiveDayWeather.new
		# @weathers = cache.get_message
		@weathers = {
			25 => ["阴转多云", "16~20"],
			26 => ["阴转多云", "16~20"],
			27 => ["阴转多云", "16~20"],
			28 => ["阴转多云", "16~20"],
			29 => ["阴转多云", "16~20"]
		}
  end

  def life_index

  end

  def air_quality

  end

  def healthy_weather

  end
end