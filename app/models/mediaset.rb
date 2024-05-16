# == Schema Information
#
# Table name: mediasets
#
#  id         :bigint           not null, primary key
#  name       :string
#  ready      :boolean          default(FALSE)
#  state      :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_mediasets_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Mediaset < ApplicationRecord
  belongs_to :product
  belongs_to :user
  belongs_to :company, optional: true
  has_many :entities
end
