FactoryGirl.define do
  factory :mention do
    message_id  1
    slack_id    "U023BECGF"
    name        "Slack User 001"
    profile_picture_url "http://hoge.io/001.jpg"
  end
end
