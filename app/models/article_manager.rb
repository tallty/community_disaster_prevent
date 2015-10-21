# == Schema Information
#
# Table name: article_managers
#
#  id            :integer          not null, primary key
#  keyword       :string(255)
#  article_index :integer
#  page_url      :string(255)
#  article_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  article_type  :string(255)
#  community_id  :integer
#

class ArticleManager < ActiveRecord::Base
  belongs_to :article
  belongs_to :community

  attr_accessor :district
end
