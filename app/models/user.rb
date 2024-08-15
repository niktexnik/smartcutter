# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  agreement       :boolean          default(FALSE)
#  email           :string
#  email_confirmed :boolean          default(FALSE)
#  first_name      :string
#  last_name       :string
#  middle_name     :string
#  password_digest :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_phone  (phone) UNIQUE
#
class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([\w+-].?)+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A.*(?=.*\d)(?=.*[!@#$%^&*]).*\z/

  has_many :devices, inverse_of: :user, dependent: :destroy
  has_many :sessions, through: :devices, dependent: :destroy
  has_many :email_confirmations, class_name: 'Users::EmailConfirmation', inverse_of: :user, dependent: :destroy
  has_many :reset_password_confirmations, class_name: 'Users::ResetPasswordConfirmation', inverse_of: :user,
                                          dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :mediasets, through: :products
  has_one :company, dependent: :destroy
  before_save :downcase_email
  after_create :generate_email_confirmation_token

  validates :email, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }, uniqueness: true

  has_secure_password

  def logout_all_user_sessions(exception = nil)
    sessions.where.not(id: exception.try(:id)).access_token_active.map(&:logout)
  end

  def generate_email_confirmation_token
    email_confirmations.create(confirmation_token: SecureRandom.hex(32),
                               confirmation_token_expires_at: 1.month.from_now)
  end

  def generate_reset_password_token
    reset_password_confirmations.create(reset_token: SecureRandom.hex(32), reset_token_expires_at: 5.minutes.from_now)
  end

  def full_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  private

  def downcase_email
    email&.downcase!
  end
end
