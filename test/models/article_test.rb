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

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
