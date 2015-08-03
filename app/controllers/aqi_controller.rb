class AqiController < ApplicationController
  layout "weixin"
  
  def show
    id = params[:id]
    @time = id
    @picture = "/images/aqiquailty/#{id}.png"

  end
end