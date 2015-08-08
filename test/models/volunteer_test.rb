# == Schema Information
#
# Table name: volunteers
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  tel           :string(255)
#  commun        :string(255)
#  neighborhood  :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  subscriber_id :integer
#

require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
