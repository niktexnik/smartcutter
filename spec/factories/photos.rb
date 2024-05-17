FactoryBot.define do
  factory :photo do
    file_size { Faker::Number.between(from: 100, to: 1000) }
    height { Faker::Number.between(from: 100, to: 1000) }
    width { Faker::Number.between(from: 100, to: 1000) }
    entity
    mediaset
  end
end
