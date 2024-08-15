# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  agreement       :boolean          default(FALSE)
#  email           :string
#  email_confirmed :boolean          default(FALSE)
#  first_name      :string
#  last_name       :string
#  middle_name     :string
#  password_digest :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_phone  (phone) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    agreement { true }
    email_confirmed { true }
    password { 'Password123!' }

    trait :with_device do
      after(:create) do |user|
        create(:device, :with_session, user:)
      end
    end

    trait :with_company do
      after(:create) do |user|
        create(:company, user:)
      end
    end

    trait :with_product do
      after(:create) do |user|
        create(:product, user:)
      end
    end

    trait :product_with_mediaset do
      after(:create) do |user|
        create(:product, :with_mediaset, user:)
      end
    end

    trait :product_with_assets do
      after(:create) do |user|
        create(:product, :with_all_assets, user:)
      end
    end

    trait :with_patterns do
      after(:create) do |user|
        create(:product, :with_patterns, user:)
      end
    end

    trait :with_email_confirmation do
      after(:create) do |user|
        create(:email_confirmation, user:)
      end
    end

    trait :with_reset_password_confirmation do
      after(:create) do |user|
        create(:reset_password_confirmation, user:)
      end
    end
  end
end
