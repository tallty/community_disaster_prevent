module CommunitiesHelper
  def showCommunityName(district, street)
    district == street ? district : district + street
  end
end
