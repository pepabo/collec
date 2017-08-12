json.name 'mesages'
json.count @messages.count
json.set! :messages do
  json.array! @messages do |message|
    json.id message.id
    json.user_id message.user_id
    json.message message.message
    json.due_at message.due_at
    json.require_confirm message.require_confirm
    json.created_at message.created_at
    json.updated_at message.updated_at
  end
end
