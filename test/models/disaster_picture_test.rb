# == Schema Information
#
# Table name: disaster_pictures
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  disaster_id        :integer
#

require 'test_helper'

class DisasterPictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
