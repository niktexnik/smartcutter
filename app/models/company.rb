# == Schema Information
#
# Table name: companies
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(FALSE)
#  build       :string
#  city        :string
#  description :string
#  flat        :string
#  logo        :string
#  name        :string
#  street      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_companies_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Company < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :mediasets, dependent: :destroy
end
