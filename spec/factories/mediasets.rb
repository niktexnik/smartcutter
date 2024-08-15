# == Schema Information
#
# Table name: mediasets
#
#  id         :bigint           not null, primary key
#  name       :string
#  ready      :boolean          default(FALSE)
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_mediasets_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :mediaset do
    first_name { Faker::Lorem.word }
    ready { false }
    state { :empty }

    trait :with_entities_with_original_photo do
      after(:create) do |mediaset|
        5.times { create(:entity, :with_original_photo, mediaset:) }
      end
      state { :not_empty }
    end

    trait :with_entities_with_processed_photo do
      after(:create) do |mediaset|
        5.times { create(:entity, :with_processed_photo, mediaset:) }
      end
      state { :not_empty }
    end
  end
end
