FactoryBot.define do
  factory :sms_confirmation do
    code { rand(1000..9999) }
    confirmed_at { nil }
    count_failure_input { 0 }
    state { 'pending' }
    association :device
  end
end
