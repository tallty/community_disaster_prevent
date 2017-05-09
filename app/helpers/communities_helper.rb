module CommunitiesHelper
  def showCommunityName community
    community.district == community.street ? community.district : community.district + community.street
  end
end
