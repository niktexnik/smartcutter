# == Schema Information
#
# Table name: patterns
#
#  id          :bigint           not null, primary key
#  image       :string
#  name        :string
#  road_height :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint           not null
#
# Indexes
#
#  index_patterns_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :pattern do
    image do
      Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'pattern.svg'), 'image/svg')
    end
    name { Faker::Lorem.word }
    road_height { Faker::Number.between(from: 1, to: 100) }
  end
end
