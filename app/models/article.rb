# == Schema Information
#
# Table name: articles
#
#  id                 :integer          not null, primary key
#  event_key          :string(255)
#  title              :string(255)
#  author             :string(255)
#  content_source_url :string(255)
#  content            :text(65535)
#  digest             :string(255)
#  show_cover_pic     :integer
#  article_type       :string(255)
#  is_show            :string(255)
#  thumb_media_url    :string(255)
#  keywords           :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Article < ActiveRecord::Base
  

end
