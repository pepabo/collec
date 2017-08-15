FactoryGirl.define do
  factory :user do
    name     "Slack User 001"
    provider "slack"
    slack_id "U023BECGF"
    email    "slack_user_001@hoge.io"
    token    "aaaaaaaa"
    password "iiiiiiii"
  end
end
