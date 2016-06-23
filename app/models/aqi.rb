class AQI < BaseForecast
  AQI_HIS_URL = "http://222.66.83.20:9090/aqi_avg_hours"

  attr_accessor :time, :aqi, :o3, :pm10, :pm2_5, :no2, :aqi_item, :pm10_c, :pm2_5_c, :o3_c, :no2_c

  def initialize
    super
  end

  # （微信页面）：空气质量
  def get_web_message
    content = get_data
    if content['Result'] == true
      list = content["Data"]["AQIDatas"]

      # 发布时间
      publish_time = Time.strptime(content["Data"]["PublisDate"], "%Y年%m月%d日 %H时").to_time
      p publish_time
      aqi = []
      level = []
      pripoll = []

      list.each do |item|
        # AQI
        aqi << item['AQI']
        # 空气质量等级
        level << item["Level"]
        # 首要污染物
        pripoll << item["Pripoll"]
      end
      
      { time: publish_time, aqi: aqi, level: level, pripoll: pripoll }
    end
  end

  # 过去24小时空气质量
  def self.get_history_by_city city
    url = "#{AQI_HIS_URL}/#{city}"
    response = RestClient.get(URI::escape(url))
    infos = MultiJson.load response rescue []

    infos.map do |info|
      aqi_weather = AQI.new
      aqi_weather.o3_c = info["o3"] if info["o3"].present?
      aqi_weather.pm2_5_c = info["pm2_5"] if info["pm2_5"].present?
      aqi_weather.pm10_c = info["pm10"] if info["pm10"].present?
      aqi_weather.no2_c = info["no2"] if info["no2"].present?
      aqi_weather.time = DateTime.parse info["time"]
      aqi_weather.fill_aqi_item
      aqi_weather
    end
  end

  # 图文消息
  def get_show_article
    file_dir = "public/images/aqiquailty/"
    now_time = get_now_time
    file_name = now_time.strftime('%Y-%m-%d')
    file = File.join(file_dir, "#{file_name}.png")
    unless File.exist?(file)
      build_picture
    end

    articles = [{ :title => "#{now_time.strftime('%Y年%m月%d日 17时发布')}", :desc => "", :image_url => "#{Settings.ProjectSetting.url}/images/aqiquailty/#{file_name}.png", :page_url => "#{Settings.ProjectSetting.url}/aqi/#{file_name}" }]
    { :type => 'articles', :content => articles }
  end

  def parse
    build_picture
  end

  def after_process
  end

  def fill_aqi_item
    self.pm2_5 = AQI.cal_aqi pm2_5_c, :pm2_5
    self.pm10 = AQI.cal_aqi pm10_c, :pm10
    self.o3 = AQI.cal_aqi o3_c, :o3
    self.no2 = AQI.cal_aqi no2_c, :no2
    self.aqi = [o3.to_i, pm10.to_i, pm2_5.to_i, no2.to_i].max
    if aqi == pm2_5
      self.aqi_item = "PM2.5"
    elsif aqi == pm10
      self.aqi_item = "PM10"
    elsif aqi == o3
      self.aqi_item = "O3"
    elsif aqi == no2
      self.aqi_item = "NO2"
    end 
  end

  def self.cal_aqi raw_value, type
    aqi_map = {
      pm10: {
        (0..50) => (0..50),
        (50..150) => (50..100),
        (150..250) => (100..150),
        (250..350) => (150..200),
        (350..420) => (200..300),
        (420..500) => (300..400),
        (500..600) => (400..500),
        (600..6000) => (500..600)
      },
      pm2_5: {
        (0..35) => (0..50),
        (35..75) => (50..100),
        (75..115) => (100..150),
        (115..150) => (150..200),
        (150..250) => (200..300),
        (250..350) => (300..400),
        (350..500) => (400..500),
        (500..6000) => (500..600)
      },
      o3: {
        (0..160) => (0..50),
        (160..200) => (50..100),
        (200..300) => (100..150),
        (300..400) => (150..200),
        (400..800) => (200..300),
        (800..1000) => (300..400),
        (1000..1200) => (400..500),
        (1200..6000) => (500..600)
      },
      no2: {
        (0..100) => (0..50),
        (100..200) => (50..100),
        (200..700) => (100..150),
        (700..1200) => (150..200),
        (1200..2340) => (200..300),
        (2340..3090) => (300..400),
        (3090..3840) => (400..500),
        (3840..6000) => (500..600)
      }
    }
    convert_map = aqi_map[type]
    convert_map.each do |k, v|
      if k.include? raw_value
        c_low = k.begin
        c_high = k.end
        i_low = v.begin
        i_high = v.end
        api_value = (i_high - i_low).to_f * (raw_value - c_low) / (c_high - c_low) + i_low
        api_value = api_value > 500 ? 500 : api_value
        return api_value.round(0)
      end
    end
    return nil
  end

  # 整理过去24小时空气质量图表数据
  def self.organize_aqi_datas aqi_weathers
    aqi_datas = aqi_weathers.map do |aqi_weather|
      [
        aqi_weather.time.strftime("%Y/%m/%d %H:%M:%S"),
        aqi_weather.aqi ||= "-"
      ]
    end
    pm25_datas = aqi_weathers.map do |aqi_weather|
      [
        aqi_weather.time.strftime("%Y/%m/%d %H:%M:%S"),
        aqi_weather.pm2_5 ||= "-"
      ]
    end
    pm10_datas = aqi_weathers.map do |aqi_weather|
      [
        aqi_weather.time.strftime("%Y/%m/%d %H:%M:%S"),
        aqi_weather.pm10 ||= "-"
      ]
    end
    o3_datas = aqi_weathers.map do |aqi_weather|
      [
        aqi_weather.time.strftime("%Y/%m/%d %H:%M:%S"),
        aqi_weather.o3 ||= "-"
      ]
    end
    no2_datas = aqi_weathers.map do |aqi_weather|
      [
        aqi_weather.time.strftime("%Y/%m/%d %H:%M:%S"),
        aqi_weather.no2 ||= "-"
      ]
    end
    [aqi_datas, pm25_datas, pm10_datas, o3_datas, no2_datas]
  end

  private
    def build_picture
      content = get_data
      list = content["data"]["list"]
      level = get_level(list)
      has_prompt = (content["prompt"].present? ? 2 : 1)

      image = Magick::Image.read("images/airQuality/#{has_prompt}#{level}.jpg").first

      draw = Magick::Draw.new
      draw.pointsize = 28
      draw.font = 'public/assets/fonts/微软黑体.ttf'
      draw.font_weight = Magick::BoldWeight
      draw.fill = 'black'

      publish_time = content["data"]["publishtime"] #.strftime("%Y年%m月%d日 17时发布")
      # publish_time = Time.zone.parse(content["data"]["publishtime"])#.strftime("%Y年%m月%d日 17时发布")

      draw.annotate(image, 0, 0, 230, 116, "(#{publish_time})")

      i = 0

      base_y = [230, 320, 420]
      level = nil
      pripoll = nil
      len = nil
      offset_x = 0
      list[0, 3].each do |item|
        draw.annotate(image, 0, 0, get_offset_x_by_aqi("#{item['aqi']}"), base_y[i], "#{item['aqi']}")
        # 空气质量等级
        level = item["level"]
        len = level.length
        font_size = (len > 6) ? 24 : 28
        draw.pointsize = font_size
        offset_x = 470 - (((level.length - 1)>> 1) * font_size)
        offset_x = offset_x - (font_size >> 1) if len % 2 == 0
        draw.annotate(image, 0, 0, offset_x, base_y[i], level)
        # 首要污染物
        pripoll = item["pripoll"]
        if pripoll.length > 1
          index = pripoll.index(/[\d]/, 0)
          pripoll_alpha = pripoll[0, index]
          pripoll_digit = pripoll[index, pripoll.length]
          draw.pointsize = 28
          draw.annotate(image, 0, 0, 660 - pripoll_alpha.length * 12, base_y[i], pripoll_alpha)
          draw.pointsize = 20
          draw.annotate(image, 0, 0, 666, base_y[i] + 10, pripoll_digit)
        else
          draw.pointsize = 28
          draw.annotate(image, 0, 0, 646, base_y[i], pripoll)
        end
        draw.pointsize = 28
        i = i + 1
      end

      file_dir = "public/images/aqiquailty"
      FileUtils.makedirs(file_dir) unless File.exist?(file_dir)
      now_time = get_now_time
      pic_file = File.join(file_dir, "#{now_time.strftime('%Y-%m-%d')}.png")

      image.write(pic_file)
    end

    def get_offset_x_by_aqi(content)
      len = content.length
      len = (len - 1) >> 1
      return 300 - (len * 14)
    end

    def get_level(content)
      max_data = 0
      content.each do |item|
        refs = /(\d{1,3}).{1}(\d{1,3})/.match(item["aqi"])[2]
        refs = refs.to_f
        max_data = refs if refs > max_data
      end

      case max_data
      when 0..100
        return 1
      when 100..150
        return 2
      when 150..200
        return 3
      when 200..300
        return 4
      else
        return 5
      end
    end

    def get_now_time
      now_time = Time.now
      now_time.strftime("%H%M").to_i > 1730 ? now_time : now_time - 1.day
    end
end
