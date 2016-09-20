class Lightning

  def self.process
    p "#{Time.now}: process lightning task..."
    LightningProcess.new.process
  end

  def self.get_pic
    $redis.get("lightning_cache")
  end

  class LightningProcess < BaseFtpFile
    def initialize
      super

      @redis_key = "lightning_cache"
      @redis_last_report_time_key = "lightning_pic_last_report_time"
    end

    def ftpfile_format day
      "DISCH_#{day.strftime('%Y%m%d')}*.jpeg"
    end

    def parse local_file
      lightning_dir = './public/lightning/'

      FileUtils.mkdir_p(lightning_dir) unless File.exist?(lightning_dir)
      FileUtils.cp(local_file, lightning_dir)
    
      filename = File.basename local_file
      $redis.set(@redis_key, filename)
    end
  end

  class LightningPoint
    include NetworkMiddleware

    def initialize
      @root = self.class.name.to_s
      super
    end

    def fetch
      params_hash = {
        method: 'get'
      }
      #{Time.now().strftime('%Y%m%d%H%M%S').to_s}
      @api_path = "#{@api_path}/20160606211200"
      result = get_data(params_hash, {})

      result.fetch('Data', {})
    end
  end
end
