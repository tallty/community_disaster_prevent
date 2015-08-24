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
      code = subscriber.community.code
    end
    content = $redis.hvals("warnings_#{code}")
    if content.present?
      articles = []
      publishtime = nil
      content.each do |item|
        item = MultiJson.load item rescue {}
        publishtime = Time.parse(item["publish_time"]).strftime("%m月%d日 %H点%M分")
        if item["status"].eql?("解除")
          articles << { :title => "上海中心气象台#{publishtime}解除#{item['type']}#{item['level']}预警", :desc => "", :image_url => "#{Settings.ProjectSetting.url}/assets/images/warnings/b_#{Warning.tran_type(item['type'])}#{Warning.tran_level(item['level'])}g.png", :page_url => "#{Settings.ProjectSetting.url}/warnings/#{item['community']}" }
        else
          articles << { :title => "上海中心气象台#{publishtime}发布#{item['type']}#{item['level']}预警", :desc => "", :image_url => "#{Settings.ProjectSetting.url}/assets/images/warnings/b_#{Warning.tran_type(item['type'])}#{Warning.tran_level(item['level'])}.png", :page_url => "#{Settings.ProjectSetting.url}/warnings/#{item['community']}" }
        end
      end
      { :type => 'articles', :content => articles }
    else
      { :type => 'text', :content => '当前无预警' }
    end
  end

  class CityWarningProcess < BaseForecast
    def initialize
      super
    end

    def parse
      content = get_data
      if content.present?
        warning = nil
        community = Community.where(district: "上海").first
        content.each do |item|

          if item["level"].eql?("解除")
            warning_level = Warning.where(warning_type: item["type"], community: community).order(id: "desc").limit(1).first.level
            warning = Warning.find_or_create_by(publish_time: Time.parse(item["publishtime"]), warning_type: item["type"])
            warning.level = warning_level
            warning.content = item["content"]
            warning.community = community
            warning.status = "解除"
            warning.save
          else
            warning = Warning.find_or_create_by(publish_time: Time.parse(item["publishtime"]), warning_type: item["type"])
            warning.level = item["level"]
            warning.content = item["content"]
            warning.community = community
            warning.save
          end
          $redis.hset("warnings_#{community.code}", "#{warning.warning_type}", warning.to_json)
        end
      end
    end

    def after_process

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
          community = Community.where("street like ?", "%#{item["unit"]}%").first
          next if community.nil?
          publish_time = Time.strptime(item["publish_time"],"%Y年%m月%d日%H时%M分").to_time
          warning = Warning.find_or_create_by(publish_time: publish_time, warning_type: item["warning_type"])
          warning.status = item["status"]
          warning.level = item["level"]
          warning.content = item["content"]
          warning.community = community

          $redis.hset("warnings_#{community.code}", "#{warning.warning_type}", warning.to_json)
        end
      end
    end

    def after_process

    end
  end

  def self.tran_level(text)
    level = {"蓝色" => 1, "黄色" => 2, "橙色" => 3, "红色" => 4, "解除" => 5, "I" => 6, "II" => 7, "III" => 8, "IV" => 9}
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
      "臭氧" => "o"
    }
    type = warning_type[text]
  end

  def clear_cache
    warning_key = $redis.keys "warnings_*"
    clear_time = Time.now - 3.hours
    warning_key.each do |key|
      $redis.hgetall(key).map do |e, item|
        item = MultiJson.load item
        $redis.hdel(key, e) if Time.parse(item["publish_time"]) < clear_time and item["level"].eql?("解除")
      end

    end
  end
end
