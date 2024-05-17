# == Schema Information
#
# Table name: products
#
#  id                 :bigint           not null, primary key
#  enabled            :boolean          default(TRUE)
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  company_id         :bigint           not null
#  pattern_id         :integer
#  product_setting_id :integer
#
# Indexes
#
#  index_products_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    enabled { true }
    company
  end
end
