FactoryGirl.define do
  factory :message_answer do
    association :message
    association :message_button
    association :mention
  end
end
