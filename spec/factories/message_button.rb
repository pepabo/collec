FactoryGirl.define do
  factory :message_button do
    association :message
    sequence(:name)  { |n| "name#{n}" }
    sequence(:text)  { |n| "text#{n}" }
  end
end
