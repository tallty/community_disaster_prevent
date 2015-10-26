module Admin
  class MonitorStationsController < ApplicationController
    before_action :set_monitor_station, only: [:edit, :update, :destroy]

    def index
      @monitor_stations = MonitorStation.all
    end

    def down
      file = MonitorStation.export
      io = File.open(file)
      io.binmode
      send_data(io.read, :filename => "monitor_stations.xlsx", :disposition => 'attachment')
    end

    def new
      @monitor_station = MonitorStation.new
    end

    def edit
      
    end

    def create
      @monitor_station = MonitorStation.new()
      @monitor_station.station_name = monitor_station_params[:station_name]
      @monitor_station.station_number = monitor_station_params[:station_number]
      @monitor_station.station_type = monitor_station_params[:station_type]
      community = Community.where(street: monitor_station_params[:community]).first
      @monitor_station.community = community
      respond_to do |format|
        if @monitor_station.save
          format.html { redirect_to new_admin_monitor_station_path }
          format.json { render :show, status: :created, location: @monitor_station }
        else
          format.html { render :new }
          format.json { render json: @monitor_station.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @monitor_station.destroy
      respond_to do |format|
        format.html { redirect_to admin_monitor_stations_url, notice: 'Monitor Station was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_monitor_station
        @monitor_station = MonitorStation.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def monitor_station_params
        params.require(:monitor_station).permit(:station_name, :station_number, :community, :station_type)
      end
  end
end
