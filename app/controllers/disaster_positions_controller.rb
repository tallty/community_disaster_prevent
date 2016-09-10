class DisasterPositionsController < ApplicationController
  layout 'weixin'

  def new
    # @subscriber = Subscriber.where(openid: session[:openid]).first
    @subscriber = Subscriber.first
    @disaster_positions = DisasterPosition.new
  end

  def create
    @disaster_position = DisasterPosition.create(disaster_position_params)
    if @disaster_position.save
      redirect_to new_disaster_path(disaster_position_id: @disaster_position.id)
    else
    end
  end

  private
  def disaster_position_params
    params.require(:disaster_position).permit(:lon, :lat, :address)
  end
end