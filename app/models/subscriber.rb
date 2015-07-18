# == Schema Information
#
# Table name: subscribers
#
#  id         :integer          not null, primary key
#  openid     :string(255)
#  sex        :integer
#  city       :string(255)
#  province   :string(255)
#  country    :string(255)
#  headimgurl :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  nick_name  :string(255)
#

class Subscriber < ActiveRecord::Base

  def process
    subscriber = Subscriber.new
    subscriber.fetch_user_id
    subscriber.fetch_user_info
  end

  def fetch_user_id(next_openid=nil)
    verify_client
    result = $client.followers(next_openid)
    
    return unless result.result['count'] > 0
    result.result['data']['openid'].each do |id|
      user = Subscriber.find_or_create_by(openid: id)
      user.save
    end
    next_openid = result.result['next_openid']
    
    if next_openid.present?
      fetch_user_id(next_openid)    
    end

    nil
  end

  def fetch_user_info
    subscriber_list = Subscriber.where("nick_name is null")
    return if subscriber_list.length == 0
    verify_client
    subscriber_list.each do |item|
      begin
        result = $client.user(item.openid)  
      rescue Exception => e
        next
      end
      
      if result.code == 40001
        $client ||= WeixinAuthorize::Client.new(WeixinRailsMiddleware.config.app_id, WeixinRailsMiddleware.config.weixin_secret_string)
        return
      end
      
      item.nick_name = result.result['nickname']
      item.sex = result.result['sex'].to_i
      item.city = result.result['city']
      item.province = result.result['province']
      item.country = result.result['country']
      item.headimgurl = result.result['headimgurl']
      item.save  
    end
    subscriber_list = nil
  end

  def update_subscriber(open_id)
    logger.debug "新关注粉丝id: #{open_id}"
    begin
      subscriber = $client.user(open_id)
      user = Subscriber.find_or_create_by(openid: open_id)
      user.nick_name = subscriber.result['nickname']
      user.sex = subscriber.result['sex'].to_i
      user.city = subscriber.result['city']
      user.province = subscriber.result['province']
      user.country = subscriber.result['country']
      user.headimgurl = subscriber.result['headimgurl']
      logger.debug "新关注粉丝: #{user.to_json}"
      user.save 
    rescue => e
      puts "#{e}"
      # next
    end
  end

  private
  def verify_client
    unless $client.is_valid?
      $client ||= WeixinAuthorize::Client.new(WeixinRailsMiddleware.config.app_id, WeixinRailsMiddleware.config.weixin_secret_string) 
    end
  end
end
