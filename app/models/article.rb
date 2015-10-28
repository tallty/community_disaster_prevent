# == Schema Information
#
# Table name: articles
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  author          :string(255)
#  content         :text(65535)
#  digest          :string(255)
#  thumb_media_url :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Article < ActiveRecord::Base
  include BaseWeixin
  has_one :article_manager, dependent: :destroy
  validates :title, :content, presence: true

  def get_show_article
    subscriber = Subscriber.where(openid: @subscriber).first
    if subscriber.community.present?
      if ["社区风险", "调查问卷"].include?(@keyword)
        if subscriber.community.status.eql?("closed")
          return { :type => 'text', :content => "您所在社区暂未开放此服务" }
        else
          if @keyword.eql?('调查问卷')
            publish_surveys = PublishSurvey.where(community_id: subscriber.community, status: 1)
            # surveys = Survey.where(community: subscriber.community)
            if publish_surveys.present?
              contents = ""
              publish_surveys.each do |publish_survey|
                survey = publish_survey.survey
                url = weixin_url("surveys/#{survey.id}")
                contents << "<a href='#{url}'>#{survey.s_title}</a>" << "\r\n"
              end
              return { :type => 'text', :content => contents }
            else
              return { :type => 'text', :content => "当前无#{@keyword}信息" }      
            end
          else
            articles = ArticleManager.where(keyword: @keyword, community: subscriber.community)  
          end
          
        end
      else
        articles = ArticleManager.where(keyword: @keyword)
      end
      results = []
      if articles.present?
        articles.each do |item|
          if item.page_url.present?
            results << { :title => item.article.title, :desc => item.article.digest, :image_url => "#{Settings.ProjectSetting.url}/#{item.article.thumb_media_url}", :page_url => weixin_url("#{item.page_url}") }
          else
            results << { :title => item.article.title, :desc => item.article.digest, :image_url => "#{Settings.ProjectSetting.url}/#{item.article.thumb_media_url}", :page_url => weixin_url("articles/#{item.article.id}") }
          end
        end
        { :type => 'articles', :content => results }
      else
        { :type => 'text', :content => "当前无#{@keyword}信息" }
      end
    else
      binding_community
    end
  end
end
