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
#  asset_id    :integer
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
  has_one :manual_processed_photo, class_name: '::ManualProcessedPhoto', dependent: :destroy
  has_one :background_asset, class_name: 'Background', dependent: :nullify
  has_one :road_asset, class_name: 'Road', dependent: :nullify
  has_one :watermark_asset, class_name: 'Watermark', dependent: :nullify
  has_many :processed_photos, -> { order(created_at: :asc) }, class_name: '::ProcessedPhoto', dependent: :destroy, inverse_of: :entity
  has_one :cutted_photo, -> { where(step: 'cut').order(created_at: :desc) }, class_name: '::ProcessedPhoto', dependent: :destroy, inverse_of: :entity
  has_one :shadows_photo, -> { where(step: 'shadow').order(created_at: :desc) }, class_name: '::ProcessedPhoto', dependent: :destroy, inverse_of: :entity
  has_one :blure_plates_photo, -> { where(step: 'blure_plates').order(created_at: :desc) }, class_name: '::ProcessedPhoto',
                                                                                            dependent: :destroy,
                                                                                            inverse_of: :entity
  has_one :tint_windows_photo, -> { where(step: 'tint_window').order(created_at: :desc) }, class_name: '::ProcessedPhoto',
                                                                                           dependent: :destroy,
                                                                                           inverse_of: :entity
  has_one :background_photo, -> { where(step: 'background').order(created_at: :desc) }, class_name: '::ProcessedPhoto', dependent: :destroy, inverse_of: :entity
  has_one :road_photo, -> { where(step: 'road').order(created_at: :desc) }, class_name: '::ProcessedPhoto', dependent: :destroy, inverse_of: :entity
  has_one :watermark_photo, -> { where(step: 'watermark').order(created_at: :desc) }, class_name: '::ProcessedPhoto', dependent: :destroy, inverse_of: :entity
  has_one :final_photo, -> { where(step: 'final').order(created_at: :desc) }, class_name: '::ProcessedPhoto', dependent: :destroy, inverse_of: :entity

  scope :order_by_position, -> { order(position: :asc) }

  # validates :position, uniqueness: { scope: :mediaset_id }
end
