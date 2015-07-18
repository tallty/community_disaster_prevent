class OauthController < ApplicationController
  layout 'wechat'
  def index
    @code = params[:code]
    p @code
    obj = $client.get_oauth_access_token("#{params[:code]}")
    p obj
    # url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{WeixinRailsMiddleware.config.app_id}&secret=67b21dc39ca1e6a46a2551d7589d3c1c&code=#{params[:code]}&grant_type=authorization_code"
    # info = RestClient.get(URI::escape(url))
    # obj = MultiJson.load(info)
    # p obj
  end
end