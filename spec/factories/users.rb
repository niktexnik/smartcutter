# == Schema Information
#
# Table name: users
#
#  id                                :bigint           not null, primary key
#  agreement                         :boolean          default(FALSE)
#  count_of_failure_sms_confirmation :integer          default(0)
#  email                             :string
#  middle_name                       :string
#  name                              :string
#  phone                             :string
#  surname                           :string
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  company_id                        :integer
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    surname { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    agreement { true }
    count_of_failure_sms_confirmation { 0 }

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
  end
end
