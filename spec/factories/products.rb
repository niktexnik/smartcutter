# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  enabled    :boolean          default(TRUE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_products_on_company_id  (company_id)
#  index_products_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    enabled { true }
  end

  trait :user_product do
    user
  end

  trait :company_product do
    company
  end

  trait :with_new_mediaset do
    after(:create) do |product|
      create(:mediaset, :with_entities_with_original_photo, product:)
    end
  end

  trait :with_processed_mediaset do
    after(:create) do |product|
      create(:mediaset, :with_entities_with_processed_photo, product:)
    end
  end

  trait :with_all_assets do
    after(:create) do |product|
      create(:asset, :with_background, product:)
      create(:asset, :with_road, product:)
      create(:asset, :with_watermark, product:)
    end
  end

  trait :with_all_patterns do
    after(:create) do |product|
      create(:pattern, :front_view, product:)
      create(:pattern, :back_view, product:)
      create(:pattern, :left_side_view, product:)
      create(:pattern, :right_side_view, product:)
      create(:pattern, :front_angle_left_view, product:)
      create(:pattern, :front_angle_right_view, product:)
      create(:pattern, :back_angle_left_view, product:)
      create(:pattern, :back_angle_right_view, product:)
    end
  end

  trait :with_products_setting do
    after(:create) do |product|
      create(:products_setting, product:)
    end
  end
end
