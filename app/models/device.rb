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
#  index_devices_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Device < ApplicationRecord
  PLATFORMS = %w[ios android app_gallery].freeze
  PLATFORMS_DICTIONARY = { ios: 'iOS',
                           android: 'Android',
                           app_gallery: 'app_gallery' }.stringify_keys.freeze

  belongs_to :user, inverse_of: :devices, optional: true
  has_many :sessions, dependent: :destroy
  has_many :sms_confirmations, dependent: :destroy

  validates :identifier, :platform, presence: true, allow_nil: false
  validates :identifier, uniqueness: { scope: %i[user_id platform] }, if: proc { |device| device.user_id.present? }
  validates :platform, inclusion: { in: PLATFORMS }

  scope :active, -> { where(active: true) }
  scope :sorted, -> { order(updated_at: :desc) }
  scope :confirmed, -> { where.not(confirmed_at: nil).sorted }

  def close_all_sessisons
    sessions.update_all(access_token_expires_at: nil, refresh_token: nil, refresh_token_expires_at: nil)
  end

  def create_new_session(ip:)
    sessions.create(access_token: SessionRecord.generate_token(:access_token),
                    token_expires_at: 30.days.from_now,
                    refresh_token: SessionRecord.generate_token(:access_token, 512),
                    refresh_token_expires_at: 2.months.from_now,
                    ip:)
  end
end
