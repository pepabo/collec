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

  json.set! :mentioned do
    json.array! @message.mentions do |m|
      json.name                m.name
      json.profile_picture_url m.profile_picture_url

      json.set! :answers do
        json.array! m.message_answers do |a|
          json.answer            @message.message_buttons.find { |b| b.id == a.message_button_id }.text
          json.answered_date     a.updated_at
        end
      end
    end
  end
end
