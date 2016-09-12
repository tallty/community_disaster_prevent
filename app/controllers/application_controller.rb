class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
	# 判断浏览器
	def is_wechat_brower?
    user_agent = request.env['HTTP_USER_AGENT'].try(:downcase)
    return user_agent.include? "micromessenger"
  end
end