json.array!(@article_managers) do |article_manager|
  json.extract! article_manager, :id
  json.url article_manager_url(article_manager, format: :json)
end
