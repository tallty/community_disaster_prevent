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

end