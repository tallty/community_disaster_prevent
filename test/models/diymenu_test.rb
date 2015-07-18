# == Schema Information
#
# Table name: diymenus
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  name       :string(255)
#  key        :string(255)
#  url        :string(255)
#  is_show    :boolean
#  sort       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DiymenuTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
