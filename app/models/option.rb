# == Schema Information
#
# Table name: options
#
#  id           :integer          not null, primary key
#  option_title :string(255)
#  question_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Option < ActiveRecord::Base
  belongs_to :question
end
