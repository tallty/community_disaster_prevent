class FiveDayWeather
  attr_accessor :datatime, :direction, :speed, :tempe, :weather

  def as_json(options=nil)
    {
      datatime: datatime,
      direction: direction,
      speed: speed,
      tempe: tempe,
      weather: weather
    }
  end

  def initialize
    settings = Settings.__send__ self.class.to_s
    @data_url = settings.url
  end

  def get_message
    conn = Faraday.new(:url => Settings.DataUrl) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    result = "未来上海五日天气:\n"
    response = conn.get @data_url

    content = MultiJson.load response.body
    datetime = nil
    limit_day = Time.zone.now.to_date + 4.day
    content.each do |weather|
      datetime = Time.zone.parse(weather["datatime"])
      if datetime < limit_day
        result << "#{datetime.strftime('%d日')} #{weather['weather']} #{weather['tempe']}\n"
      end
    end
    { :type => 'text', :content => result }
  end

  # 微信网页版：五日天气
  def get_web_message
    conn = Faraday.new(:url => Settings.DataUrl) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = conn.get @data_url

    result = {}
    content = MultiJson.load response.body
    datetime = nil
    now_day = Time.zone.now.to_date

    # now_day = Time.zone.parse(item["datatime"]).to_date
    limit_day = Time.zone.now.to_date + 4.day

    content.each do |item|
      datetime = Time.zone.parse(item["datatime"]).to_date
      # if datetime <= limit_day && datetime >= now_day
        temp = item['tempe'].delete("℃").split("~")
        cache = { low: temp.first, 
                  high: temp.last, 
                  weather: "#{item['weather']}", 
                  direction: "#{item['direction']}", 
                  speed: "#{item['speed']}" 
                }
        result["#{datetime}"] = cache
      # end
    end
    # {日期 => {低温，高温，天气, 风向， 风速}, ...}
    result
  end

  # 拆分天气
  def self.split_weather weather
    if weather.include? "转"
      data = weather.split('转')
    else
      data = [weather, weather]
    end
    return data
  end

  # 获取天气的关键词（用于图标）
  # 返回图标类
  def self.weather_keyword weather
    if weather.include? ','
      result = weather.split(',').first
    elsif weather.include? '到'
      result = weather.split('到').first
    elsif weather.include? '有'
      result = weather.split('有').first
    else
      result = weather
    end

    icon = FiveDayWeather.icon_class result
    icon.blank? ? "icon-lingdang" : icon
  end

  # 五日天气图标
  def self.icon_class name
    cache = {
      "阴" => "icon-cloud",
      "晴" => "icon-taiyang",
      "多云" => "icon-duoyun",

      "暴雪" => "icon-baoxue",
      "大雪" => "icon-daxue",
      "中雪" => "icon-zhongxue",
      "小雪" => "icon-xiaoxue",
      "小到中雪" => "icon-xiaodaozhongxue",

      "雨夹雪" => "icon-yujiaxue",
      "阵雪" => "icon-daxue",
      "冰雹" => "weather_hail",

      "特大暴雨" => "icon-tedabaoyu",
      "大暴雨" => "icon-dabaoyu",
      "暴雨" => "icon-baoyu",
      "大雨" => "icon-dayu",
      "中雨" => "icon-zhongyu",
      "小雨" => "icon-xiaoyu",

      "阵雨" => "icon-zhongyu",
      "雷阵雨" => "icon-leizhenyu",
      "冻雨" => "icon-dongyu",

      "强沙尘暴" => "icon-dust",
      "沙尘暴" => "icon-dust",
      "浮尘" => "icon-dust",
      "扬沙" => "icon-dust",

      "雾" => "icon-fog",
      "霾" => "icon-haze"
    }
    return cache[name]
  end

end
