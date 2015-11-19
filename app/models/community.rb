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

  def write_community_to_file
    file = File.new('./public/community.txt', 'w')
    Community.all.each do |item|
      file.write("#{item.code}\t#{item.district}\t#{item.street}\t#{item.c_type}\r\n")
    end
    file.close
  end
end
