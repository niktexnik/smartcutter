# == Schema Information
#
# Table name: patterns
#
#  id          :bigint           not null, primary key
#  image       :string
#  name        :string
#  road_height :integer
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  entity_id   :bigint           not null
#  product_id  :bigint           not null
#
# Indexes
#
#  index_patterns_on_entity_id   (entity_id)
#  index_patterns_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (entity_id => entities.id)
#  fk_rails_...  (product_id => products.id)
#
class Pattern < ApplicationRecord
  belongs_to :product
  belongs_to :entity
end
