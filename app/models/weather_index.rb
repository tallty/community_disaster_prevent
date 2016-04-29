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
  def self.get_web_message
    shows = ["体感指数(上午)", "穿衣指数(早晨)", "洗晒指数(上午)", "户外晚间锻炼指数"]
    result = {}
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
        result[title] = [item['level'], item['shortcues']]
      end
    end
    result
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