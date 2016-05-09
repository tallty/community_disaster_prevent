module ForecastServicesHelper
	# 生活指数图标
	def life_index_icon name
		cache = {
			"体感指数" => "icon-collect",
			"穿衣指数" => "icon-yifu",
			"洗晒指数" => "icon-xiyiji",
			"户外晚间锻炼指数" => "icon-pingpang",
			"空调开启指数" => "icon-kongtiao",
			"洗车指数" => "icon-xichezhishu",
			"中暑指数" => "icon-baowen",
			"日照指数" => "icon-taiyangxian"
		}
		cache[name]
	end

	# 健康气象图标
	def healthy_weather_icon name
		cache = {
			"COPD患者气象风险" => "icon-feibu",
			"儿童哮喘气象风险" => "icon-yaopingmp",
			"老年人感冒气象风险" => "icon-old-man",
			"儿童感冒气象风险" => "icon-muying",
			"成人感冒气象风险" => "icon-zhenguan",
			"慢性阻塞性肺病气象风险" => "icon-feibu"
		}
		cache[name]
 	end
end