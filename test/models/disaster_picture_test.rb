# == Schema Information
#
# Table name: disaster_pictures
#
#  id                 :integer          not null, primary key
#  file_name          :string(255)
#  url                :string(255)
#  local_path         :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  data_file_name     :string(255)
#  data_content_type  :string(255)
#  data_file_size     :integer
#  data_updated_at    :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

require 'test_helper'

class DisasterPictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
