FactoryBot.define do
  factory :session do
    access_token { SecureRandom.urlsafe_base64(256, false) }
    access_token_expires_at { Time.zone.now + 1.hour }
    ip { Faker::Internet.ip_v4_address }
    refresh_token { SecureRandom.urlsafe_base64(256, false) }
    refresh_token_expires_at { Time.zone.now + 1.week }
    association :device
  end
end
