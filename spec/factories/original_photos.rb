# == Schema Information
#
# Table name: photos
#
#  id         :bigint           not null, primary key
#  file_size  :integer
#  height     :integer
#  photo      :string
#  step       :string
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  entity_id  :bigint           not null
#
# Indexes
#
#  index_photos_on_entity_id  (entity_id)
#
# Foreign Keys
#
#  fk_rails_...  (entity_id => entities.id)
#
FactoryBot.define do
  factory :original_photo do
    photo do
      Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/image_car.jpg'), 'image/jpeg')
    end
    file_size { Faker::Number.between(from: 100, to: 1000) }
    height { Faker::Number.between(from: 100, to: 1000) }
    width { Faker::Number.between(from: 100, to: 1000) }
  end
end
