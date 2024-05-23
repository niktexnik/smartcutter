# == Schema Information
#
# Table name: patterns
#
#  id          :bigint           not null, primary key
#  image       :string
#  name        :string
#  road_height :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint           not null
#
# Indexes
#
#  index_patterns_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Pattern < ApplicationRecord
  mount_uploader :image
  belongs_to :product
end
