# == Schema Information
#
# Table name: assets
#
#  id         :bigint           not null, primary key
#  image      :string
#  name       :string
#  position   :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  entity_id  :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_assets_on_company_id  (company_id)
#  index_assets_on_entity_id   (entity_id)
#  index_assets_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (entity_id => entities.id)
#  fk_rails_...  (product_id => products.id)
#
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
