class OauthsController < ApplicationController
  before_action :store_reurl, only: [:index]
  
  def index
    openid = session[:openid]
    if openid
      redirect_to session[:reurl]
    else
      url = $client.authorize_url check_oauths_url
      redirect_to url
    end
  end

  def check
    result = $client.get_oauth_access_token(params[:code])
    openid = result.result['openid']
    p "=====================openid: #{openid}============================"
    session[:openid] = openid
    redirect_to session[:reurl]
  end

  private
  def store_reurl
    session[:reurl] = params[:reurl] if params[:reurl].present?
  end
end
