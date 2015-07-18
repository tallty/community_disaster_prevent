json.array!(@diymenus) do |diymenu|
  json.extract! diymenu, :id
  json.url diymenu_url(diymenu, format: :json)
end
