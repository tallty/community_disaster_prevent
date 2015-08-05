class MonitorStation < ActiveRecord::Base
  include BaseWeixin

  belongs_to :community
  attr_accessor :search

  scope :stations, -> { all.distinct(:station_number) }

  def process
    station_types = {"自动站" => "s_auto_station", "积水站" => "s_water_stations"}
    stations = MonitorStation.stations
    stations.each do |item|
      url = "#{base_url}&type=#{station_types[item.station_type]}&sitenumber=#{item.station_number}"
      data = get_data url
      p data
      $redis.hset("monitor_stations", item.station_number, data)
    end
    nil
  end

  def get_show_article
    subscriber = Subscriber.where(openid: @subscriber).first
    if subscriber.community.present?
      results = [{ :title => "#{subscriber.community.district}实况监测", :desc => "", :image_url => "#{Settings.ProjectSetting.url}/images/lightning/DISCH_20150802_131000.jpeg", :page_url => weixin_url("monitor_stations") }]
      auto_station = MonitorStation.where(community: subscriber.community, station_type: "自动站").first
      data = $redis.hget("monitor_stations", auto_station.station_number)
      if data.present?
        data = MultiJson.load data
        results << { :title => "温度: #{data["tempe"]} ℃", :desc => "", :image_url => "#{Settings.ProjectSetting.url}/assets/images/temp.png", :page_url => weixin_url("monitor_stations") }
        results << { :title => "实况雨量: #{data["rain"]} mm", :desc => "", :image_url => "#{Settings.ProjectSetting.url}/assets/images/rain.png", :page_url => weixin_url("monitor_stations") }
      end
      water_stations = MonitorStation.where(community: subscriber.community, station_type: "积水站")
      max_deep = 0
      water_stations.each do |item|
        data = $redis.hget("monitor_stations", item.station_number)
        data = MultiJson.load data
        max_deep = data["data"] if data["data"].to_f > max_deep
      end
      results << { :title => "积水: #{max_deep} m", :desc => "", :image_url => "#{Settings.ProjectSetting.url}/assets/images/water.png", :page_url => weixin_url("monitor_stations") }
      if results.present?
        { :type => 'articles', :content => results }
      else
        { :type => 'text', :content => "当前无#{@keyword}信息" }
      end
    else
      binding_community
    end
  end

  private
  def base_url
    "http://61.152.122.112:8080/publicdata/data?appid=LV08MwglXetHcxdaUTIR&appkey=3LpFnUP84xhj5HaIcmKGAC2yezMgY9"
  end

  def get_data url
    conn = Faraday.new(:url => Settings.DataUrl) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.get url
    response.body
  end
end