FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    enabled { true }
    company
  end
end
