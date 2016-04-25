# 五日天气预报
class FiveDayWeathersController < ApplicationController
	layout 'weixin'

	def index
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
end