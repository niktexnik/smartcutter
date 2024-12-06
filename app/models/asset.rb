# == Schema Information
#
# Table name: assets
#
#  id         :bigint           not null, primary key
#  asset_type :string
#  image      :string
#  name       :string
#  position   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#  product_id :bigint           not null
#
# Indexes
#
#  index_assets_on_company_id  (company_id)
#  index_assets_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (product_id => products.id)
#
class Asset < ApplicationRecord
  AVALIABLE_TYPES = %w[background road watermark].freeze
  WATERMARK_POSITIONS_BASE = { center: 'Center', top: 'North', bottom: 'South', left: 'East', right: 'West',
                               northwest: 'NorthWest', northeast: 'NorthEast', southeast: 'SouthEast',
                               southwest: 'SouthWest' }.freeze
  mount_uploader :image
  belongs_to :product
  # belongs_to :user, through: :product
  belongs_to :company, optional: true

  # validates :asset_type, inclusion: { in: AVALIABLE_TYPES }

  def asset_type
    self.asset_type = self.class.name.split('::').last.downcase
  end
end
