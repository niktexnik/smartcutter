# == Schema Information
#
# Table name: sms_confirmations
#
#  id                  :bigint           not null, primary key
#  code                :integer
#  confirmed_at        :datetime
#  count_failure_input :integer
#  state               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  device_id           :bigint           not null
#
# Indexes
#
#  index_sms_confirmations_on_device_id  (device_id)
#
# Foreign Keys
#
#  fk_rails_...  (device_id => devices.id)
#
class SmsConfirmation < ApplicationRecord
  MAX_SMS_ATTEMPS = 3
  MAX_SMS_SENDS = 3
  SMS_DELAY = 2.minutes
  SMS_LIFETIME = 5
  STATES = ConstantsDictionary.new(%i[new sms_sent confirmed])
  belongs_to :device
end
