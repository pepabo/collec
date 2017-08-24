FactoryGirl.define do
  factory :user do
    name     "Slack User 001"
    provider "slack"
    slack_id "U023BECGF"
    email    "slack_user_001@hoge.io"
    token    "aaaaaaaa"
    password "iiiiiiii"

    trait :with_messages do
      after(:build) do |user|
        user.messages = []
        user.messages << FactoryGirl.build(:message, :with_mentions, :with_message_buttons)
      end
    end
  end
end
