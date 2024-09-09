# == Schema Information
#
# Table name: assets
#
#  id         :bigint           not null, primary key
#  asset_type :string
#  image      :string
#  name       :string
#  position   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#  product_id :bigint           not null
#
# Indexes
#
#  index_assets_on_company_id  (company_id)
#  index_assets_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :asset do
    name { Faker::Lorem.word }
    image do
      Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/background_asset.jpg'), 'image/jpeg')
    end
    position { Faker::Lorem.word }
    asset_type { 'background' }
    # association :company
  end

  trait :with_product do
    product
  end

  trait :with_company do
    company
  end

  # trait :with_background do
  #   after(:create) do |entity|
  #     create(:background, entity:)
  #   end
  # end
  # asset_type { 'background' }
  # image do
  #   Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/background_asset.jpg'), 'image/jpeg')
  # end

  trait :with_road do
    # asset_type { 'road' }
    # image do
    #   Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/road_asset.jpeg'), 'image/jpeg')
    # end
  end

  trait :with_watermark do
    # asset_type { 'watermark' }
    # image do
    #   Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/watermark_asset.svg'), 'image/svg')
    # end
  end
end
