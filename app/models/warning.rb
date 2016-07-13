# == Schema Information
#
# Table name: warnings
#
#  id           :integer          not null, primary key
#  publish_time :datetime
#  warning_type :string(255)
#  level        :string(255)
#  content      :text(65535)
#  community_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  status       :string(255)
#

class Warning < ActiveRecord::Base
  belongs_to :community

  def process
    CityWarningProcess.new.process
    CommunityWarningProcess.new.process
    clear_cache
  end

  def as_json(options=nil)
    {
      publish_time: publish_time,
      type: warning_type,
      level: level,
      content: content,
      status: status,
      community: community.code
    }
  end

  def get_show_article
    if @keyword.eql?("全市预警")
      code = 20000
    else
      subscriber = Subscriber.where(openid: @subscriber).first
      if subscriber.community.status.eql?("closed")
        return { :type => 'text', :content => '您所在社区暂未开放此服务' }
      else
        code = subscriber.community.code  
      end
    end
    content = $redis.hvals("warnings_#{code}")
    if content.present?
      articles = []
      content.each do |item|
        item = MultiJson.load item rescue {}
        publishtime = Time.parse(item["publish_time"]).strftime("%m月%d日 %H点%M分")

        if item["status"].eql?("解除")
          img_url = "#{Settings.ProjectSetting.url}/assets/images/warnings/b_#{Warning.tran_type(item['type'])}#{Warning.tran_level(item['level'])}g.png"
        else
          img_url = "#{Settings.ProjectSetting.url}/assets/images/warnings/b_#{Warning.tran_type(item['type'])}#{Warning.tran_level(item['level'])}.png"
        end
        community = Community.where(code: item['community']).first.street
        community = '' if community.eql?('上海')
        articles << { :title => "上海中心气象台#{publishtime}#{item['status']}#{community}#{item['type']}#{item['level']}预警",
                      :desc => "", :image_url => img_url,
                      :page_url => "#{Settings.ProjectSetting.url}/warnings/#{item['community']}" }
      end
      { :type => 'articles', :content => articles }
    else
      { :type => 'text', :content => '当前无预警' }
    end
  end

  class CityWarningProcess
    include NetworkMiddleware

    def initialize
      @root = self.class.name.to_s
      super
    end

    def fetch
      params_hash = {
        method: 'get',
        data: ''
      }
      result = get_data(params_hash, {})

      result.fetch('Data', {})
    end
  end

  class CommunityWarningProcess < BaseForecast
    def initialize
      super
    end

    def parse
      content = get_data
      if content["data"].present?
        warning = nil

        content["data"].each do |item|
          # community = Community.where("street like ?", "%#{item["unit"]}%").first
          community = Community.find_by_code item['unit']
          next if community.nil?
          publish_time = Time.strptime(item["publish_time"],"%Y年%m月%d日%H时%M分").to_time
          warning = Warning.find_or_create_by(publish_time: publish_time, warning_type: item["warning_type"], community: community)
          warning.status = item["status"]
          warning.level = Warning.tran_level(item["level"].to_s)
          warning.content = item["content"]
          # warning.community = community
          warning.save
          $redis.hset("warnings_#{community.code}", "#{warning.warning_type}", warning.to_json)
        end
      end
    end

    def after_process

    end
  end

  def self.tran_level(text)
    level = {
        "蓝色" => 1, "黄色" => 2, "橙色" => 3, "红色" => 4, "解除" => 5,
        "I" => 6, "II" => 7, "III" => 8, "IV" => 9,
        "1" => "I", "2" => "II", "3" => "III", "4" => "IV"}
    level[text]
  end

  def self.tran_type(text)
    warning_type = {
      "台风" => "a",
      "暴雨" => "b",
      "高温" => "c",
      "寒潮" => "d",
      "大雾" => "e",
      "雷电" => "f",
      "大风" => "g",
      "沙尘暴" => "h",
      "冰雹" => "i",
      "暴雪" => "j",
      "道路结冰" => "k",
      "干旱" => "l",
      "霜冻" => "m",
      "霾" => "n",
      "臭氧" => "o",
      "暴雨内涝" => "p",
      "雷电2" => "q"
    }
    type = warning_type[text]
  end

  def clear_cache
    warning_key = $redis.keys "warnings_*"
    clear_time = Time.now - 3.hours
    warning_key.each do |key|
      $redis.hgetall(key).map do |e, item|
        item = MultiJson.load item
        $redis.hdel(key, e) if Time.parse(item["publish_time"]) < clear_time and item["status"].eql?("解除")
      end

    end
  end

  # 获取最新未解除的预警
  def self.get_last_active_warn code
    warnings = $redis.hvals("warnings_#{code}").map do |e|
      MultiJson.load(e)
    end
    cache = warnings.select{|x| x['status'] != '解除'}
    return cache.sort { |a, b| b['publish_time']<=>a['publish_time'] }.first
  end

  class Warning
  
  end
end
