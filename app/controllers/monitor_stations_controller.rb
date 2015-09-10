class MonitorStationsController < ApplicationController
  layout 'weixin'
  def index

  end

  def show
    subscriber = Subscriber.where(openid: params[:openid]).first
    if subscriber.present?
      @community = subscriber.community
      @lightning = ""
      @auto_station_info = MonitorStation.where(community: @community, station_type: "自动站").first
      @water_station_infos = MonitorStation.where(community: @community, station_type: "积水站")
      auto_station_data = $redis.hget("monitor_stations", @auto_station_info.station_number)
      @auto_station = MultiJson.load auto_station_data
      @water_stations = []
      @water_station_infos.each do |item|
        @water_stations << MultiJson.load($redis.hget("monitor_stations", item.station_number)) rescue {}
      end
      p "--------------------------------------------------------------------------------"
      p @water_stations.present?
      p @water_stations
      p "--------------------------------------------------------------------------------"
    else
    end
  end

end
