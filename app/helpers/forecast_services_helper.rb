module ForecastServicesHelper
  # 五日天气图标日期
  def five_day key
    if key.to_date == Date.today 
      '今天'
    elsif key.to_date == Date.tomorrow
      '明天'
    else 
      week_name key 
    end 
  end

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
			"日照指数" => "icon-taiyang",
      "火险指数" => "icon-fire"
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
			"青少年和成年人感冒气象风险" => "icon-zhenguan",
			"慢性阻塞性肺病气象风险" => "icon-feibu"
		}
		cache[name]
 	end

 	# 处理空气质量名词格式
 	def aqi_format kpi
    match = /([a-zA-Z]+)([0-9,.]+)/.match kpi
    if match.present?
      "#{match[1]}<span class=\"aqi-small\">#{match[2]}</span>".html_safe
    else
      kpi
    end
  end

  # 空气质量时间
  def air_time datas
  	time = datas.collect { |x| x[0] }
  end

  # 空气质量值
  def air_data datas
  	data = datas.collect { |x| x[1] }
  end

  # aqi级别
  # 数组
  def aqi_levels range
    p "range: #{range}"
    low = /(\d{1,3}).{1}(\d{1,3})/.match(range)[0].to_f
    high = /(\d{1,3}).{1}(\d{1,3})/.match(range)[2].to_f
    return [air_level(low), air_level(high)]
  end

  # 根据数值判断级别
  def air_level refs
    case refs
    when 0..50
      return 1
    when 50..100
      return 2
    when 100..150
      return 3
    when 150..200
      return 4
    when 200..300
      return 5
    else
      return 6
    end
  end

  # 拆分空气质量级别
  def split_air_level level, now_air
    if level.include? '到'
      result = level.split('到')
      "<div class='multi-tips-l color#{aqi_levels(now_air)[0] }'>#{result[0]}</div><div class='multi-tips-r color#{aqi_levels(now_air)[1] }'>#{result[-1]}</div>"
    else
      "<div class='simple-tips color#{aqi_levels(now_air)[0] }'>#{level}</div>"
    end
  end
end
