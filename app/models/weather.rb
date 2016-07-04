class Weather

  class FiveDayWeather
    include NetworkMiddleware

    def initialize
      @api_path = "JsonService/JsonService.svc/Get5DayForecast_Weixin"
      @remote = "http://61.152.126.152/"
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
      @api_path = "/JsonService/JsonService.svc/GetDistrictAutoStationDataByName/"
      @remote = "http://61.152.126.152/"
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
