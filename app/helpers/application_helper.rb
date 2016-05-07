module ApplicationHelper

  def to_rad lng1, lat1, lng2, lat2
    # 经度差值
    dx = (lng1 - lng2).abs
    # 纬度差值
    dy = (lat1 - lat2).abs
    # 平均纬度
    b = (lat1 + lat2) / 2.0
    # 用平面的矩形对角距离公式计算总距离
    return Math::sqrt((dx/180 * Math::PI * 6367000.0 * Math.cos(b/180 * Math::PI)) * (dx/180 * Math::PI * 6367000.0 * Math.cos(b/180 * Math::PI)) + (6367000.0 * (dy/180 * Math::PI)) * (6367000.0 * (dy/180 * Math::PI)))
  end

	def week_name time
		index = time.to_date.strftime("%w").to_i
		cache = {0 => "周日", 1 => "周一", 2 => "周二", 3 => "周三", 4 => "周四", 5 => "周五", 6 => "周六"}
		cache[index]
	end
end
