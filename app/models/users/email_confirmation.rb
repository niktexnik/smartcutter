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
module Users
  class EmailConfirmation < ApplicationRecord
    belongs_to :user, class_name: '::User'

    after_create :send_confirmation_email

    def send_confirmation_email
      return if Rails.env.staging? || Rails.env.development?

      NotifierMailer.confirm_email(user).deliver_now
    end
  end
end
