# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  enabled    :boolean          default(TRUE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_products_on_company_id  (company_id)
#  index_products_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#
class Product < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :user, optional: true
  has_many :mediasets, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :patterns, dependent: :destroy
  # has_one :background_asset, class_name: 'Assets::Background', dependent: :destroy
  # has_one :road_asset, class_name: 'Assets::Road', dependent: :destroy
  # has_one :watermark_asset, class_name: 'Assets::Watermark', dependent: :destroy
  has_one :products_setting, class_name: 'Products::Setting', dependent: :destroy

  accepts_nested_attributes_for :products_setting, allow_destroy: true
end
