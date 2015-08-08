# == Schema Information
#
# Table name: surveys
#
#  id           :integer          not null, primary key
#  s_title      :string(255)
#  s_digest     :string(255)
#  s_author     :string(255)
#  community_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Survey < ActiveRecord::Base
end
