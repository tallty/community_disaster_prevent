class Weather

  def self.forecast_short_week_date date
    report_date = DateTime.parse(date)
    if report_date == Time.zone.today
      "今天"
    elsif report_date == Time.zone.today + 1
      "明天"
    else
      I18n.localize report_date, format: "%f"
    end
  end

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
      response = get_data(params_hash, {})
      result = []
      response.fetch('Data', {}).each do |item|
        result << {
          Time: Weather.forecast_short_week_date(item['Time']),
          Day: item['Day'],
          Night: item['Night'],
          LowTmp: item['LowTmp'],
          HighTmp: item['HighTmp'],
          Wind: item['Wind'],
          WindLev: item['WindLev']
        }
      end
      result
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
