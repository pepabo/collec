FactoryGirl.define do
  factory :message_button do
    name { "name#{id}" }
    text { "text#{id}" }
  end
end
