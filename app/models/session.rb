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
class Session < ApplicationRecord
  belongs_to :device, inverse_of: :sessions

  validates :access_token, presence: true
  delegate :user, to: :device, allow_nil: true

  scope :access_token_active, -> { where('access_token_expires_at > ?', Time.zone.now) }
  scope :refresh_token_active, -> { where('refresh_token_expires_at > ?', Time.zone.now).where.not(refresh_token: nil) }

  def self.generate_token(field, length = 256)
    loop do
      random_token = SecureRandom.urlsafe_base64(length, false)
      break random_token unless exists?(field => random_token)
    end
  end

  def logout
    update(access_token_expires_at: nil, refresh_token_expires_at: nil, refresh_token: nil)
  end
end
