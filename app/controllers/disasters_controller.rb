class DisastersController < ApplicationController
  before_action :set_subscriber, only: [:create]
  before_action :set_disaster, only: [:show]
  layout 'weixin'

  def index
    @subscriber = Subscriber.where(openid: params[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
  end

  def show

  end

  def new
    @subscriber = Subscriber.where(openid: params[:openid]).first
    @disaster = Disaster.new
  end

  def create
    p @subscriber
    @disaster = Disaster.find_or_create_by(occur_time: Time.parse(disaster_params[:occur_time]), subscriber: @subscriber)
    @disaster.disaster_type = disaster_params[:disaster_type]
    @disaster.explain = disaster_params[:explain]
    if @disaster.save
      redirect_to new_disaster_picture_path(disaster_id: @disaster.id)
    else
      redirect_to ''
    end
  end

  private
    def set_subscriber
      @subscriber = Subscriber.where(openid: disaster_params[:openid]).first
    end

    def set_disaster
      @disaster = Disaster.where(id: params[:id]).first
    end

    def disaster_params
      params.require(:disaster).permit(:openid, :occur_time, :disaster_type, :explain)
    end
end
