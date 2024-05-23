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
require 'rails_helper'

RSpec.describe SmsRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
