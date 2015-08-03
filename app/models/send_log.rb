# == Schema Information
#
# Table name: send_logs
#
#  id         :integer          not null, primary key
#  start_time :datetime
#  end_time   :datetime
#  status     :string(255)
#  count      :integer
#  explain    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SendLog < ActiveRecord::Base
end
