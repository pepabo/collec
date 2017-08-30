FactoryGirl.define do
  factory :mention do
    association :message
    slack_id { "ABCDEFG0#{id}" }
    name { "USER0#{id}"}
    profile_picture_url { "http://hoge/user0#{id}.jpg" }
    channel "DXXXXXXXX"
    ts "1503499924.000735"
    text "question 000001"
  end
end
