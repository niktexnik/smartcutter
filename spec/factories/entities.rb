# == Schema Information
#
# Table name: entities
#
#  id          :bigint           not null, primary key
#  name        :string
#  position    :integer
#  ready       :boolean
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  mediaset_id :bigint           not null
#  pattern_id  :integer
#
# Indexes
#
#  index_entities_on_mediaset_id  (mediaset_id)
#
# Foreign Keys
#
#  fk_rails_...  (mediaset_id => mediasets.id)
#
FactoryBot.define do
  factory :entity do
    name { Faker::Lorem.word }
    position { Faker::Number.unique.between(from: 1, to: 100) }
    ready { [true, false].sample }
    state { Faker::Lorem.word }
    mediaset

    trait :with_original_photo do
      after(:create) do |entity|
        create(:original_photo, entity:)
      end
    end

    trait :with_processed_photo do
      after(:create) do |entity|
        create(:processed_photo, entity:)
      end
    end
  end
end
