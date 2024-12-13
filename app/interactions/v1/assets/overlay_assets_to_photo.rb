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

      def remove_photos(entity)
        entity.background_photo&.destroy
        entity.watermark_photo&.destroy
      end

      def start_process
        @entities.each do |entity|
          remove_photos(entity)
          process_overlay(entity)
        end
      end

      def process_overlay(entity)
        background = load_image(@overlayed_background)
        processed_photo = load_image(entity.processed_photos.last.photo.path)
        resize_to_product_settings(processed_photo)

        result_image = overlay_image(background, processed_photo, nil, position: 'South')

        entity.create_background_photo(photo: result_image)

        if watermark_asset_path
          watermark = prepare_watermark
          result_image = overlay_image(result_image, watermark, nil, position: watermark_position)
          entity.create_watermark_photo(photo: result_image)
        end
      end
    end
  end
end
