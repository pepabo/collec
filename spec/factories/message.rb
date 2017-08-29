FactoryGirl.define do
  factory :message do
    association :user
    message 'Slack User 001: Message 00001'
    due_at '2017-08-12T09:47:29.000Z'
    button_type 0
    require_confirm true

    trait :with_mentions do
      after(:build) do |message|
        message.mentions = []
        2.times { message.mentions << FactoryGirl.build(:mention) }
      end
    end

    trait :with_message_buttons do
      after(:build) do |message|
        message.message_buttons = []
        2.times { message.message_buttons << FactoryGirl.build(:message_button) }
      end
    end
  end
end
