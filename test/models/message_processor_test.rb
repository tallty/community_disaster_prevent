# == Schema Information
#
# Table name: message_processors
#
#  id                 :integer          not null, primary key
#  event_key          :string(255)
#  process_class_name :string(255)
#  process_method     :string(255)
#  result_type        :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class MessageProcessorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
