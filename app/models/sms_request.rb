# == Schema Information
#
# Table name: sms_requests
#
#  id         :bigint           not null, primary key
#  ip         :inet
#  phone      :string
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SmsRequest < ApplicationRecord
  STATES = { success: 'success', failed: 'failed' }.freeze
end
