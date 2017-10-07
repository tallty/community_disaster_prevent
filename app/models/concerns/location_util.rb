class LocationUtil

  include NetworkMiddleware

  def initialize
    # @api_path = 'geocoder/v2/'
    # @remote = 'http://api.map.baidu.com'
    # @ak = '8SWaIs2cE83Ssvv90yXPUEQQhnkG368u'
    @root = self.class.to_s
    super
  end

  def reverse(params)
    lon = params[:lon]
    lat = params[:lat]
    result = get_data({method: 'get', data: "?ak=#{@ak}&location=#{lat},#{lon}&coordtype=wgs84ll&output=json&pois=0"},{})
    result.fetch('result', {})
  end
end
