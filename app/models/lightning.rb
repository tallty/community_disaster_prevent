class Lightning

  def self.process
    p "#{Time.now}: process lightning task..."
    LightningProcess.new.process
  end

  class LightningProcess < BaseFtpFile
    def initialize
      super

      @redis_key = "lightning_cache"
      @redis_last_report_time_key = "lightning_pic_last_report_time"
    end

    protected
    def ftpfile_format day
      "DISCH_#{day.strftime('%Y%m%d')}_*.jpeg"
    end

    def parse local_file
      lightning_dir = './public/lightning/'

      FileUtils.mkdir_p(lightning_dir) unless File.exist?(lightning_dir)
      FileUtils.cp(local_file, lightning_dir)
    
      filename = File.basename local_file
      $redis.set(@redis_key, filename)
    end
  end
end
