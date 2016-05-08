module BaseWeixin
  def binding_community
    { :type => 'articles', :content => [{ :title => "社区绑定", :desc => "", :image_url => "#{Settings.ProjectSetting.url}/assets/images/community2.png", :page_url => "#{Settings.ProjectSetting.url}/subscribers/new?openid=#{@subscriber}" }]}
  end

  def weixin_url(url)
    "#{Settings.ProjectSetting.url}/#{url}?openid=#{@subscriber}"
  end
end
