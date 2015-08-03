json.array!(@send_logs) do |send_log|
  json.extract! send_log, :id
  json.url send_log_url(send_log, format: :json)
end
