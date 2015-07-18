# == Schema Information
#
# Table name: disaster_positions
#
#  id         :integer          not null, primary key
#  lon        :float(24)
#  lat        :float(24)
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DisasterPositionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
