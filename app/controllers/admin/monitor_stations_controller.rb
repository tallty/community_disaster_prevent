module Admin
  class MonitorStationsController < ApplicationController
    layout 'admin/home'

    def index
      @monitor_stations = MonitorStation.all
    end
  end
end
