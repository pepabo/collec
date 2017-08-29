FactoryGirl.define do
  factory :message_button do
    association :message
    name { "name#{id}" }
    text { "text#{id}" }
  end
end
