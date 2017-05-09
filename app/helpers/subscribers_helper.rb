module SubscribersHelper
  def showCommunityName(district, street)
    district == street ? district : district + street
  end
end
