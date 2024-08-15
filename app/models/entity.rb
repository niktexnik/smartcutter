# == Schema Information
#
# Table name: entities
#
#  id          :bigint           not null, primary key
#  name        :string
#  position    :integer
#  ready       :boolean
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  mediaset_id :bigint           not null
#  pattern_id  :integer
#
# Indexes
#
#  index_entities_on_mediaset_id  (mediaset_id)
#
# Foreign Keys
#
#  fk_rails_...  (mediaset_id => mediasets.id)
#
class Entity < ApplicationRecord
  belongs_to :mediaset, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_one :original_photo, class_name: '::OriginalPhoto', dependent: :destroy
  has_one :processed_photo, class_name: '::ProcessedPhoto', dependent: :destroy
  has_one :manual_processed_photo, class_name: '::ManualProcessedPhoto', dependent: :destroy

  # validates :position, uniqueness: { scope: :mediaset_id }
end
