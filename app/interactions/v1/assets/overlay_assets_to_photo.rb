# module V1
#   module Assets
#     class OverlayAssetsToPhoto < OverlayAssets
#       def call(overlayed_background, entities, settings)
#         @overlayed_background = overlayed_background
#         @entities = entities
#         @settings = settings
#         start_process
#       end

#       private

#       def start_process
#         @entities.each do |entity|
#           process_overlay(entity)
#         end
#       end

#       def process_overlay(entity)
#         background = load_image(@overlayed_background)
#         processed_photo = load_image(entity.processed_photos.last.photo.path)

#         result_image = overlay_image(background, processed_photo, calculate_offset(processed_photo, background), position: 'South')
#         entity.create_background_photo(photo: resize_to_product_settings(result_image))
#         if watermark_asset_path
#           watermark = prepare_watermark
#           result_image = overlay_image(result_image, watermark, nil, position: watermark_position)
#         end
#         entity.create_watermark_photo(photo: resize_to_product_settings(result_image))
#       end

#       def apply_transparency(image, opacity)
#         image.combine_options do |c|
#           c.alpha 'set'
#           c.channel 'A'
#           c.evaluate 'multiply', opacity
#         end
#         image
#       end

#       def prepare_watermark
#         watermark = load_image(watermark_asset_path)
#         watermark = remove_background(watermark)
#         apply_transparency(watermark, 0.1) # TO DO: get opacity from settings @settings.watermark_opacity and maybe crop
#         watermark
#       end

#       def remove_background(image)
#         image.format('png') do |c|
#           c.fuzz '20%'
#           c.transparent 'white'
#         end
#         image
#       end

#       def watermark_asset_path
#         @watermark_asset_path ||= product.watermark_asset&.image&.path
#       end

#       def product
#         @product ||= @settings.product
#       end

#       def watermark_position
#         # watermark_asset&.position || 'Center'
#         'Center'
#       end
#     end
#   end
# end
module V1
  module Assets
    class OverlayAssetsToPhoto < OverlayAssets
      def call(overlayed_background, entities, settings)
        @overlayed_background = overlayed_background
        @entities = entities
        @settings = settings
        start_process
      end

      private

      def start_process
        @entities.each do |entity|
          process_overlay(entity)
        end
      end

      def process_overlay(entity)
        background = load_image(@overlayed_background)
        processed_photo = load_image(entity.processed_photos.last.photo.path)

        result_image = overlay_image(background, processed_photo, calculate_offset(processed_photo, background), position: 'South')

        entity.create_background_photo(photo: resize_to_product_settings(result_image))

        if watermark_asset_path
          watermark = prepare_watermark
          result_image = overlay_image(result_image, watermark, nil, position: watermark_position)
          entity.create_watermark_photo(photo: resize_to_product_settings(result_image))
        end
      end
    end
  end
end
