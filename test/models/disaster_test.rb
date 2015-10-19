# == Schema Information
#
# Table name: disasters
#
#  id                   :integer          not null, primary key
#  occur_time           :datetime
#  disaster_type        :string(255)
#  explain              :text(65535)
#  subscriber_id        :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  disaster_position_id :integer
#

require 'test_helper'

class DisasterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
