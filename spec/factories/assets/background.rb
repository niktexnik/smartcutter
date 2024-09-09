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
  factory :background, class: Assets::Background do
    name { Faker::Lorem.word }
    image do
      Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/background_asset.jpg'), 'image/jpeg')
    end
    position { Faker::Lorem.word }
    association :company
  end
end
