FactoryGirl.define do
  factory :message do
    message 'hoge'
    slack_user
  end

  factory :slack_user do
    slack_user_id = 1
    access_token = 'aaaaaaaaaaaaaaaa'

    factory :slack_user_with_messages do
      transient do
        messages_count 10
      end

      after(:create) do |slack_user, evaluator|
        create_list(:message, evaluator.messages_count, slack_user: slack_user)
      end
    end
  end
end
