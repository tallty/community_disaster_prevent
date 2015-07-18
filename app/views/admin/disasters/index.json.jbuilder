json.array!(@disasters) do |disaster|
  json.extract! disaster, :id
  json.url disaster_url(disaster, format: :json)
end
