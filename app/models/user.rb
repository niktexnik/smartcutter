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
end
