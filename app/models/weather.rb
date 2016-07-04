class Weather

  class FiveDayWeather
    include NetworkMiddleware

    def initialize
      @root = self.class.to_s
      super 
    end

    def fetch
      params_hash = {
        method: 'get',
        data: ''
      }
      result = get_data(params_hash, {})

      result.fetch('Data', {})
    end
  end

  class DistrictWeather
    include NetworkMiddleware

    def initialize
      @root = self.class.to_s
      super 
    end

    def fetch district
      params_hash = {
        method: 'get',
        data: district
      }
      result = get_data(params_hash, {})
      result.fetch('Data', {})
    end
  
  end
end
