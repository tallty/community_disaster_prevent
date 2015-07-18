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

class MessageProcessor < ActiveRecord::Base

  def self.process_request(keyword, subscriber)
    processor = MessageProcessor.find_by(event_key: keyword)
    p processor
  end
end
