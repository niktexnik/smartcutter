FactoryBot.define do
  factory :entity do
    name { Faker::Lorem.word }
    position { Faker::Number.unique.between(from: 1, to: 100) }
    ready { [true, false].sample }
    state { Faker::Lorem.word }
    mediaset
  end
end
