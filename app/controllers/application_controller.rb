class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :invoke_wx_auth
  # before_action :get_wechat_sns, if: :is_wechat_brower?

  private
  # 调用微信授权获取openid
  # def invoke_wx_auth
  #   if params[:state].present? || !is_wechat_brower? \
  #     || session['openid'].present? || session[:user_id].present? 
  #     return # 防止进入死循环授权
  #   end
  #   # 生成授权url，再进行跳转
  #   sns_url =  $client.authorize_url(request.url)
  #   redirect_to sns_url and return
  # end

  # # 在invoke_wx_auth中做了跳转之后，此方法截取
  # def get_wechat_sns
  #   # params[:state] 这个参数是微信特定参数，所以可以以此来判断授权成功后微信回调。
  #   if session[:openid].blank? && params[:state].present?
  #     sns_info = $client.get_oauth_access_token(params[:code])
  #     Rails.logger.debug("Weixin oauth2 response: #{sns_info.result}")
  #     # 重复使用相同一个code调用时：
  #     if sns_info.result["errcode"] != "40029"
  #       session[:openid] = sns_info.result["openid"]
  #     end
  #   end
  # end

	# 判断浏览器
	def is_wechat_brower?
    user_agent = request.env['HTTP_USER_AGENT'].try(:downcase)
    return user_agent.include? "micromessenger"
  end
end