class WeatherIndex < BaseForecast
  
  def get_message
    shows = ["体感指数(上午)", "穿衣指数(早晨)", "洗晒指数(上午)", "户外晚间锻炼指数"]
    result = ""
    name = ""
    content = get_data
    list = content["data"]["list"]
    list.each do |item|
      name = item["name"]
      if shows.include?(name)
        title = name.remove!("(早晨)")
        title = name.remove!("(上午)")
        title = name.remove!("(下午)")
        title = name.remove!("(晚上)")
        result << "#{title} #{item['level']} #{item['shortcues']}\n"
      end
    end
    { :type => 'text', :content => result }  
  end

  # 获取（微信页面版）生活指数数据
  class WeatherIndexData < BaseForecast
    def initialize
      super
    end

    def get_web_message
      shows = ["体感指数", "户外晚间锻炼指数", "穿衣指数", "日照指数", "洗晒指数", "空调开启指数", "洗车指数", "中暑指数", "火险指数", "感冒指数"]
      result = {}
      name = ""
      content = get_data
      publishtime = nil
      
      content.fetch("Data", []).each do |item|
        name = item["Name"]
        p "=================="
        p item
        p "=================="
        publishtime = item['PublishTime'] if publishtime.blank?
        if shows.include?(name)
          _descriptions = item['Descriptions']
          _descriptions.each do |desc|
            _time = desc['Time']
            if _time.eql?('上午') or _time.eql?('早晨') or _time.blank?
              result[name] = [desc['Level'], desc['Comfort']]  
            end
          end
        end
      end
      [result, publishtime]
    end
  end
  
  def initialize
    super
  end

  def parse
    content = get_data
    p content
  end

  def after_process
  end

  private

end
