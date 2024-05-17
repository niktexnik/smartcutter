FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    description { Faker::Company.catch_phrase }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    user
  end
end
