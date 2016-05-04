module ApplicationHelper

	def week_name time
		index = time.to_date.strftime("%w").to_i
		cache = {0 => "周日", 1 => "周一", 2 => "周二", 3 => "周三", 4 => "周四", 5 => "周五", 6 => "周六"}
		cache[index]
	end
end
