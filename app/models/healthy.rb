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
      healthy_hash = {
                      'COPD患者' => {:target => 'copd', :title => '慢性阻塞性肺病气象风险'},
                      '儿童感冒' => {:target => 'child-cloud', :title => '儿童感冒气象风险'},
                      '儿童哮喘' => {:target => 'child-asthma', :title => '儿童哮喘气象风险'},
                      '老年人感冒' => {:target => 'older-cloud', :title => '老年人感冒气象风险'},
                      '青少年和成年人感冒' => {:target => 'adult-cloud', :title => '成人感冒气象风险'},
                     }
      healthies = []
      content = get_data
      results = content.fetch('Data', [])
      results.each do |item|
        _content = healthy_hash[item['Crow']]
        _content[:content] = [
          {
            :date => format_date(item['Deatails'][0]['Date']),
            :level => item['Deatails'][0]['WarningLevel'],
            :desc => item['Deatails'][0]['WarningDesc'],
            :influ => item['Deatails'][0]['Influ'],
            :guide => item['Deatails'][0]['Wat_guide']
          },
          {
            :date => format_date(item['Deatails'][1]['Date']),
            :level => item['Deatails'][1]['WarningLevel'],
            :desc => item['Deatails'][1]['WarningDesc'],
            :influ => item['Deatails'][1]['Influ'],
            :guide => item['Deatails'][1]['Wat_guide']
          }
        ]
        healthies << _content
      end
      healthies
    end

    def format_date date
      report_date = DateTime.parse(date)
      if report_date == Time.zone.today
        '今天'
      elsif report_date == Time.zone.today + 1
        '明天'
      else
        I18n.localize report_date, format: '%a'
      end
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
