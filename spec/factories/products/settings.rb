# == Schema Information
#
# Table name: products_settings
#
#  id               :bigint           not null, primary key
#  add_shadows      :boolean          default(FALSE)
#  blure_plates     :boolean          default(FALSE)
#  blure_windows    :boolean          default(FALSE)
#  enabled          :boolean          default(TRUE)
#  image_height     :integer          default(1080)
#  image_width      :integer          default(1920)
#  images_count     :integer          default(3)
#  need_processing  :boolean          default(TRUE)
#  output_extension :string           default("png")
#  pattern_ids      :string           default([]), is an Array
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :bigint           not null
#
# Indexes
#
#  index_products_settings_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :products_setting, class: 'Products::Setting' do
    blure_windows { false }
    blure_plates { false }
    add_shadows { false }
    need_processing { true }
    enabled { true }
    product
  end
end
