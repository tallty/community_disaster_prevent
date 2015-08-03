class BaseForecast
  
  def initialize
    settings = Settings.__send__ self.class.to_s
    @data_url = settings.url
  end

  def process
    parse
    after_process
  end

  private
  def get_data
    conn = Faraday.new(:url => Settings.DataUrl) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.get @data_url
    content = MultiJson.load response.body
  end
end