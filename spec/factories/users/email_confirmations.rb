# == Schema Information
#
# Table name: users_email_confirmations
#
#  id                            :bigint           not null, primary key
#  confirmation_token            :string
#  confirmation_token_expires_at :datetime
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  user_id                       :bigint           not null
#
# Indexes
#
#  index_users_email_confirmations_on_confirmation_token  (confirmation_token) UNIQUE
#  index_users_email_confirmations_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :email_confirmation, class: 'Users::EmailConfirmation' do
    confirmation_token { SecureRandom.hex(32) }
    confirmation_token_expires_at { 1.month.from_now }
  end
end
