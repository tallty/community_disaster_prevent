class UploadFilesController < ApplicationController

  def create
    require 'fileutils'
    tmp = params[:myfile]
    file_name = Time.zone.now.to_i.to_s << '.jpg'
    local_dir = "#{Rails.root}/public/media"
    
    FileUtils.makedirs(local_dir) unless File.exist?(local_dir)
    file = File.join(local_dir, file_name)
    FileUtils.cp tmp.path, file
    File.chmod(0664, file)
    render json: { pic_name: "media/#{file_name}" }  
  end

end