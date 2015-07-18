json.array!(@disaster_pictures) do |disaster_picture|
  json.extract! disaster_picture, :id
  json.url disaster_picture_url(disaster_picture, format: :json)
end
