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
  def get_web_message
    content = get_data
    shows = ["儿童感冒", "儿童哮喘", "青少年和成年人感冒", "老年人感冒", "COPD患者"]

    now_day = Time.zone.now
    results = {}

    (0..content[0].length - 1).each do |i|
      # 今明的单条指数记录
      today_item = content[0][i]
      tomorrow_item = content[1][i]

      if shows.include?(today_item["title"])
        cache = {}
        cache["#{today_item['report_time'].to_time.strftime("%Y-%m-%d")}"] = ["#{today_item['info']}", "#{today_item['guide']}"]
        cache["#{tomorrow_item['report_time'].to_time.strftime("%Y-%m-%d")}"] = ["#{tomorrow_item['info']}", "#{tomorrow_item['guide']}"]
        results["#{today_item['title']}气象风险"] = cache
      end
    end

    # {"风险种类" => {"今天" => ["防范人群", "建议"], "明天" => ["防范人群", "建议"]}, ...}
    results
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
