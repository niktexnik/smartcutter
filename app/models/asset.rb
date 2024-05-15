# == Schema Information
#
# Table name: assets
#
#  id         :bigint           not null, primary key
#  image      :string
#  name       :string
#  position   :string
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  entity_id  :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_assets_on_company_id  (company_id)
#  index_assets_on_entity_id   (entity_id)
#  index_assets_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (entity_id => entities.id)
#  fk_rails_...  (product_id => products.id)
#
class Asset < ApplicationRecord
  AVALIABLE_TYPES = %w[background road watermark].freeze
  belongs_to :product
  belongs_to :entity
  belongs_to :company
end
