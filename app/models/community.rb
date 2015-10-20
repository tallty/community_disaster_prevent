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
#  code       :integer          not null
#  status     :integer
#

class Community < ActiveRecord::Base
  has_many :warnings, dependent: :destroy
  has_one :monitor_station
  has_one :subscriber
  has_many :article_managers
  belongs_to :publish_surveys

  enum status: [ :closed, :used]
end
