class Healthy < BaseForecast

  def get_message
    content = get_data
    shows = ["COPD患者", "儿童哮喘", "老年人感冒"]
    now_day = Time.zone.now
    results = now_day.strftime("%Y-%m-%d")
    results << "\n"
    content[0].each do |item|
      if shows.include?(item["title"])
        results << "#{item['title']}气象风险等级:"
        results << "#{item['level']}级 #{item['guide']}\n"
      end
    end
    results << "\n"
    results << (now_day + 1.day).strftime("%Y-%m-%d")
    results << "\n"
    content[0].each do |item|
      if shows.include?(item["title"])
        results << "#{item['title']}气象风险等级:"
        results << "#{item['level']}级 #{item['guide']}\n"
      end
    end

    { :type => 'text', :content => results }
  end

  # 微信网页版：获取健康气象数据
  class HealthyData < BaseForecast
    def initialize
      super
      settings = Settings.__send__ self.class.to_s
      @data_url = settings.url
    end

    def get_web_message
      content = get_data
      results = content.fetch('Data', [])
      results
    end
  end
  

  def initialize
    super
  end

  def parse
    content = get_data
  end

  def after_process
  end

  private

end
