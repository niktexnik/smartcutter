# == Schema Information
#
# Table name: sessions
#
#  id                      :bigint           not null, primary key
#  access_token            :string
#  ip                      :string
#  refresh_token           :string
#  refresh_token_expire_at :datetime
#  token_expire_at         :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  device_id               :bigint           not null
#
# Indexes
#
#  index_sessions_on_device_id  (device_id)
#
# Foreign Keys
#
#  fk_rails_...  (device_id => devices.id)
#
class Session < ApplicationRecord
  belongs_to :device
end
