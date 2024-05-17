FactoryBot.define do
  factory :device do
    association :user
    identifier { Faker::Alphanumeric.alphanumeric(number: 10) }
    platform { Device::PLATFORMS.sample }
    active { true }
  end
end
