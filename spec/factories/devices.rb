# == Schema Information
#
# Table name: devices
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(FALSE)
#  app_version  :string
#  confirmed_at :datetime
#  fcm_token    :string
#  identifier   :string
#  platform     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_devices_on_user_id               (user_id)
#  index_devices_on_user_id_and_platform  (user_id,platform,identifier) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :device do
    user { build(:user) }
    identifier { Faker::Alphanumeric.alphanumeric(number: 10) }
    platform { Device::PLATFORMS.sample }
    active { true }
    app_version { '1.0.0' }
  end

  trait :with_session do
    after(:create) do |device|
      create(:session, device:)
    end
  end
end
