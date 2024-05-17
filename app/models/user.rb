# == Schema Information
#
# Table name: users
#
#  id                                :bigint           not null, primary key
#  agreement                         :boolean          default(FALSE)
#  count_of_failure_sms_confirmation :integer          default(0)
#  email                             :string
#  middle_name                       :string
#  name                              :string
#  phone                             :string
#  surname                           :string
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  company_id                        :integer
#
class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([\w+-].?)+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i
  has_many :devices, inverse_of: :user, dependent: :nullify
  has_many :sessions, through: :devices
  has_one :company

  before_save :downcase_email

  validates :phone, :count_of_failure_sms_confirmations, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_nil: true, allow_blank: true

  def downcase_email
    email.downcase! if email.present?
  end

  def full_name
    [name, middle_name, surname].join(' ').sub!(/\s+/, ' ')
  end

  def logout_all_user_sessions(exception = nil)
    sessions.where.not(id: exception.try(:id)).access_token_active.map(&:logout)
  end
end
