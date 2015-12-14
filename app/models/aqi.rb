class AQI < BaseForecast

  def initialize
    super
  end

  def get_show_article
    file_dir = "public/images/aqiquailty/"
    now_time = get_now_time
    file_name = now_time.strftime('%Y-%m-%d')
    file = File.join(file_dir, "#{file_name}.png")
    unless File.exist?(file)
      build_picture
    end

    articles = [{ :title => "#{now_time.strftime('%Y年%m月%d日 17时发布')}", :desc => "", :image_url => "#{Settings.ProjectSetting.url}/images/aqiquailty/#{file_name}.png", :page_url => "#{Settings.ProjectSetting.url}/aqi/#{file_name}" }]
    { :type => 'articles', :content => articles }
  end

  def parse
    build_picture
  end

  def after_process
  end

  private
  def build_picture
    content = get_data
    list = content["data"]["list"]
    level = get_level(list)
    has_prompt = (content["prompt"].present? ? 2 : 1)

    image = Magick::Image.read("images/airQuality/#{has_prompt}#{level}.jpg").first

    draw = Magick::Draw.new
    draw.pointsize = 28
    draw.font = 'public/assets/fonts/微软黑体.ttf'
    draw.font_weight = Magick::BoldWeight
    draw.fill = 'black'

    publish_time = content["data"]["publishtime"] #.strftime("%Y年%m月%d日 17时发布")
    # publish_time = Time.zone.parse(content["data"]["publishtime"])#.strftime("%Y年%m月%d日 17时发布")

    draw.annotate(image, 0, 0, 230, 116, "(#{publish_time})")

    i = 0

    base_y = [230, 320, 420]
    level = nil
    pripoll = nil
    len = nil
    offset_x = 0
    list.each do |item|
      draw.annotate(image, 0, 0, get_offset_x_by_aqi("#{item['aqi']}"), base_y[i], "#{item['aqi']}")
      level = item["level"]
      len = level.length
      font_size = (len > 6) ? 24 : 28
      draw.pointsize = font_size
      offset_x = 470 - (((level.length - 1)>> 1) * font_size)
      offset_x = offset_x - (font_size >> 1) if len % 2 == 0
      draw.annotate(image, 0, 0, offset_x, base_y[i], level)
      pripoll = item["pripoll"]
      if pripoll.length > 1
        index = pripoll.index(/[\d]/, 0)
        pripoll_alpha = pripoll[0, index]
        pripoll_digit = pripoll[index, pripoll.length]
        draw.pointsize = 28
        draw.annotate(image, 0, 0, 660 - pripoll_alpha.length * 12, base_y[i], pripoll_alpha)
        draw.pointsize = 20
        draw.annotate(image, 0, 0, 666, base_y[i] + 10, pripoll_digit)
      else
        draw.pointsize = 28
        draw.annotate(image, 0, 0, 646, base_y[i], pripoll)
      end
      draw.pointsize = 28
      i = i + 1
    end

    file_dir = "public/images/aqiquailty"
    FileUtils.makedirs(file_dir) unless File.exist?(file_dir)
    now_time = get_now_time
    pic_file = File.join(file_dir, "#{now_time.strftime('%Y-%m-%d')}.png")

    image.write(pic_file)
  end

  def get_offset_x_by_aqi(content)
    len = content.length
    len = (len - 1) >> 1
    return 300 - (len * 14)
  end

  def get_level(content)
    max_data = 0
    content.each do |item|
      refs = /(\d{1,3}).{1}(\d{1,3})/.match(item["aqi"])[2]
      refs = refs.to_f
      max_data = refs if refs > max_data
    end

    case max_data
    when 0..100
      return 1
    when 100..150
      return 2
    when 150..200
      return 3
    when 200..300
      return 4
    else
      return 5
    end
  end

  def get_now_time
    now_time = Time.now
    now_time.strftime("%H%M").to_i > 1730 ? now_time : now_time - 1.day
  end
end
