# == Schema Information
#
# Table name: users_reset_password_confirmations
#
#  id                     :bigint           not null, primary key
#  reset_token            :string
#  reset_token_expires_at :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           not null
#
# Indexes
#
#  index_users_reset_password_confirmations_on_reset_token  (reset_token) UNIQUE
#  index_users_reset_password_confirmations_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
module Users
  class ResetPasswordConfirmation < ApplicationRecord
    belongs_to :user

    def send_confirmation_email
      NotifierMailer.reset_password(user).deliver_now
    end
  end
end
