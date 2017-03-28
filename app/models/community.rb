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
  has_many :subscriber
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

  # 重建社区
  def self.rebuild_communities
    districts_client = Community::Districts.new
    districts = districts_client.fetch

    communities = []
    districts.each do |district|
      processor = Community::CommunityCode.new
      cache_communities = processor.fetch district['Name']
      communities.concat cache_communities
    end

    # Community.destroy_all
    communities.each do |community|
      Community.create(code: community['ID'].to_i, district: community['District_Name'], street: community['Name'], c_type: "普通")
    end
  end

  # 获取当前最近社区
  class NearestCommunity
    include NetworkMiddleware

    def initialize
      @root = self.class.name.to_s
      super
    end

    def fetch location_params
      lon = location_params[:lon]
      lat = location_params[:lat]

      params_hash = {
        method: 'get'
      }
      @api_path = "#{@api_path}/#{lon}/#{lat}"
      result = get_data(params_hash, {})

      result.fetch('Data', {})
    end
  end

  # 根据区县获取社区列表
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

  # 获取区县列表
  class Districts
    include NetworkMiddleware

    def initialize
      @root = self.class.name.to_s
      super
    end

    def fetch
      params_hash = {
        method: 'get'
      }
      result = get_data(params_hash, {})
      result.fetch('Data', {})
    end
  end
end
