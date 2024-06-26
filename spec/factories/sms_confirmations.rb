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
FactoryBot.define do
  factory :sms_confirmation do
    code { rand(1000..9999) }
    confirmed_at { nil }
    count_failure_input { 0 }
    state { 'pending' }
    association :device
  end
end
