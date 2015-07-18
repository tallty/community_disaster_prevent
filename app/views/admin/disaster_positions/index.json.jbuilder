json.array!(@disaster_positions) do |disaster_position|
  json.extract! disaster_position, :id
  json.url disaster_position_url(disaster_position, format: :json)
end
