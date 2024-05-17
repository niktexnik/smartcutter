FactoryBot.define do
  factory :mediaset do
    name { Faker::Lorem.word }
    ready { [true, false].sample }
    state { Faker::Lorem.word }
    product
  end
end
