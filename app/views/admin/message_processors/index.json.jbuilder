json.array!(@message_processors) do |message_processor|
  json.extract! message_processor, :id
  json.url message_processor_url(message_processor, format: :json)
end
