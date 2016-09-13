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

  include NetworkMiddleware

  def write_community_to_file
    file = File.new('./public/community.txt', 'w')
    Community.all.each do |item|
      file.write("#{item.code}\t#{item.district}\t#{item.street}\t#{item.c_type}\r\n")
    end
    file.close
  end

  def self.refresh_community_code
    districts = ['徐汇区', '崇明县', '黄浦区', '静安区', '静安区', '虹口区', '杨浦区', '长宁区', '普陀区', '宝山区', '闵行区',
                  '嘉定区', '青浦区', '金山区', '松江区', '奉贤区', '浦东新区', '中心城区']

    districts.each do |district|
      processor = Community::CommunityCode.new
      district_list = processor.fetch district
      district_list.each do |item|
        communtiy = Community.where("street like ?", "%#{item['Name'].delete('街道|社区|镇')}%").first
        if communtiy.present?
          communtiy.update_attributes(code: item['ID'])
        end
      end
    end
  end

  # 获取离当前位置最近的社区
  def self.fetchNearestCommunity lon, lat
    api_path = "http://61.152.126.152/JsonService/JsonService.svc/GetCommunityByXY/#{lon}/#{lat}"
    reponse = Faraday.get api_path
  end

  class CommunityCode
    include NetworkMiddleware

    def initialize
      @root = self.class.name.to_s
      super
    end

    def fetch district
      params_hash = {
        method: 'get'
      }
      @api_path = "#{@api_path}/#{district}"
      result = get_data(params_hash, {})

      result.fetch('Data', {})
    end
  end
end
