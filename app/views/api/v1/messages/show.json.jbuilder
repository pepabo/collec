json.id              @message.id
json.user_id         @message.user_id
json.message         @message.message
json.due_at          @message.due_at
json.require_confirm @message.require_confirm
json.created_at      @message.created_at
json.updated_at      @message.updated_at

json.set! :report do
  json.set! :answers do
    json.array! @answers do |answer|
      json.text        answer[:text]
      json.count       answer[:count]
      json.percentage  answer[:percentage]
    end
  end
end
