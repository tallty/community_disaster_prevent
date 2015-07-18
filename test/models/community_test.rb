# == Schema Information
#
# Table name: communities
#
#  id         :integer          not null, primary key
#  district   :string(255)
#  street     :string(255)
#  c_type     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CommunityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
