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

require 'test_helper'

class SubscriberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
