class WarningsController < ApplicationController
  layout "weixin"

  def show
    @warnings = $redis.hvals("warnings_#{params[:id]}").map do |e|
      MultiJson.load(e)
    end
  end

end
