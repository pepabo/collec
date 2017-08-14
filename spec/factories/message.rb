FactoryGirl.define do
  factory :message do
    user_id 1
    message 'Slack User 001: Message 00001'
    due_at '2017-08-12T09:47:29.000Z'
    require_confirm true
  end
end
