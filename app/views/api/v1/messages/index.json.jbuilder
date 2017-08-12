json.name 'mesages'
json.count @messages.count
json.set! :messages do
  json.array! @messages do |message|
    json.user_id message.user_id
    json.message message.message
  end
end
