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

class Community < ActiveRecord::Base
end
