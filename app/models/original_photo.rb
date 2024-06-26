# == Schema Information
#
# Table name: photos
#
#  id         :bigint           not null, primary key
#  file_size  :integer
#  height     :integer
#  photo      :string
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  entity_id  :bigint           not null
#
# Indexes
#
#  index_photos_on_entity_id  (entity_id)
#
# Foreign Keys
#
#  fk_rails_...  (entity_id => entities.id)
#
class OriginalPhoto < Photo
  belongs_to :entity
end
