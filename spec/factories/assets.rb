FactoryBot.define do
  factory :asset do
    name { Faker::Lorem.word }
    image do
      Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'example_image.jpg'), 'image/jpeg')
    end
    position { Faker::Lorem.word }
    type { Asset::AVALIABLE_TYPES.sample }
    association :product
    association :entity
    association :company
  end
end
