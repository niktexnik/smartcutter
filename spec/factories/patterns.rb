FactoryBot.define do
  factory :pattern do
    image { Faker::LoremPixel.image }
    name { Faker::Lorem.word }
    road_height { Faker::Number.between(from: 1, to: 100) }
    product
    entity
  end
end
