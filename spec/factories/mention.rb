FactoryGirl.define do
  factory :mention do
    association :message
    slack_id { "ABCDEFG0#{id}" }
    name { "USER0#{id}"}
    profile_picture_url { "http://hoge/user0#{id}.jpg" }
  end
end
