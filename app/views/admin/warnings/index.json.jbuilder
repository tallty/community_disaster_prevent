json.array!(@warnings) do |warning|
  json.extract! warning, :id
  json.url warning_url(warning, format: :json)
end
