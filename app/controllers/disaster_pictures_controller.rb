class DisasterPicturesController < ApplicationController
  before_action :set_disaster, only: [:new]
  before_action :set_subscriber
  layout 'weixin'

  def new
    @disaster_pictures = @disaster.disaster_pictures.new
  end

  def create
    images = params[:disaster_picture][:image]
    images.each do |image|
      DisasterPicture.create(disaster_id: disaster_picture_params[:disaster_id], image: image)
    end

    redirect_to disaster_path(id: disaster_picture_params[:disaster_id])
  end

  private
  def set_disaster
    @disaster = Disaster.where(id: params[:disaster_id]).first
  end

  def disaster_picture_params
    params.require(:disaster_picture).permit(:image, :disaster_id)
  end

  def set_subscriber
    @subscriber = Subscriber.where(openid: session[:openid]).first
  end
end
