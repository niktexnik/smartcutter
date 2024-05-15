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
  belongs_to :user
end
