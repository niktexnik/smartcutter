# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  agreement  :boolean          default(FALSE)
#  email      :string
#  middlename :string
#  name       :string
#  phone      :string
#  surname    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([\w+-].?)+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i
  has_many :devices, inverse_of: :user, dependent: :nullify
  has_many :sessions, through: :devices
  has_one :company

  before_save :downcase_email

  validates :phone, :count_of_failure_sms_confirmation, :phone_country_id, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_nil: true, allow_blank: true

  def downcase_email
    email.downcase! if email.present?
  end

  def full_name
    [name, middlename, surname].join(' ').sub!(/\s+/, ' ')
  end
end
