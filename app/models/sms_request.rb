class SmsRequest < ApplicationRecord
  STATES = { success: 'success', failed: 'failed' }.freeze
end
