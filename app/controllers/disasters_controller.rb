class DisastersController < ApplicationController
  before_action :set_subscriber, only: [:create]
  before_action :set_position, only: [:create]
  before_action :set_disaster, only: [:show, :destroy]
  layout 'weixin'

  def index
    openid = params[:openid] || session[:openid]
    @subscriber = Subscriber.where(openid: openid).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
  end

  def show

  end

  def new
    # @subscriber = Subscriber.where(openid: session[:openid]).first
    @subscriber = Subscriber.first
    @disaster_position = DisasterPosition.where(id: params[:disaster_position_id]).first
    @disaster = Disaster.new
  end

  def create
    occur_time = disaster_params[:occur_time]
    if occur_time.present?
      occur_time = Time.parse(disaster_params[:occur_time])
    else
      occur_time = Time.now
    end
    @disaster = Disaster.find_or_create_by(occur_time: occur_time, subscriber: @subscriber, disaster_position: @position)
    @disaster.disaster_type = disaster_params[:disaster_type]
    @disaster.explain = disaster_params[:explain]
    if @disaster.save
      redirect_to new_disaster_picture_path(disaster_id: @disaster.id)
    else
      redirect_to ''
    end
  end

  def destroy
    @disaster.destroy
    respond_to do |format|
      format.html { redirect_to interact_communities_path, notice: 'Disaster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_disaster
    start_time = Time.parse(params['start_time'])
    end_time = Time.parse(params['end_time'])
    @disaster = Disaster.between_times(start_time, end_time)
    render :json => @disaster
  end

  private
    def set_subscriber
      @subscriber = Subscriber.where(openid: disaster_params[:openid]).first
    end

    def set_position
      @position = DisasterPosition.where(id: disaster_params[:disaster_position_id]).first
    end

    def set_disaster
      @disaster = Disaster.where(id: params[:id]).first
    end

    def disaster_params
      params.require(:disaster).permit(:openid, :occur_time, :disaster_type, :explain, :disaster_position_id)
    end
end
