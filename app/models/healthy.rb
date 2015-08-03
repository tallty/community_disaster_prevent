class Healthy < BaseForecast

  def get_message
    content = get_data
    shows = ["COPD患者", "儿童哮喘", "老年人感冒"]
    content.each do |item|
      
    end
  end

  def initialize
    super
  end

  def parse
    content = get_data
  end

  def after_process
  end

  private
  
end