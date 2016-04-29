module ForecastServicesHelper
	# 生活指数图标
	def life_index_icon name
		cache = {
			"体感指数" => "icon-collect",
			"穿衣指数" => "icon-yifu",
			"洗晒指数" => "icon-xiyi",
			"户外晚间锻炼指数" => "icon-collect",
			"空调开启指数" => "icon-kongdiao",
			"洗车指数" => "icon-xichezhishu",
			"中暑指数" => "icon-baowen",
			"日照指数" => "icon-taiyangxian"
		}
		cache[name]
	end
end