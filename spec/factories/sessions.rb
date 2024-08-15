# == Schema Information
#
# Table name: sessions
#
#  id                       :bigint           not null, primary key
#  access_token             :string
#  access_token_expires_at  :datetime
#  ip                       :string
#  refresh_token            :string
#  refresh_token_expires_at :datetime
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  device_id                :bigint           not null
#
# Indexes
#
#  index_sessions_on_access_token   (access_token) UNIQUE
#  index_sessions_on_device_id      (device_id)
#  index_sessions_on_refresh_token  (refresh_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (device_id => devices.id)
#
FactoryBot.define do
  factory :session do
    device
    access_token { SecureRandom.urlsafe_base64(256, false) }
    access_token_expires_at { Time.zone.now + 1.hour }
    ip { Faker::Internet.ip_v4_address }
    refresh_token { SecureRandom.urlsafe_base64(256, false) }
    refresh_token_expires_at { Time.zone.now + 1.week }
  end
end
