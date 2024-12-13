module V1
  module Assets
    class OverlayBackgroundToRoad < OverlayAssets
      def call(product, settings)
        @product = product
        @settings = settings
        save_output(process_overlay)
      end

      private

      def process_overlay
        background = load_image(background_asset_path)
        road = prepare_road_asset(background)

        result_image = overlay_image(background, road, calculate_offset(road, background), position: 'South')
        resize_to_product_settings(result_image)
      end

      def prepare_road_asset(background)
        road = load_image(road_asset_path)
        road.resize("#{background.width}x") if road.width != background.width
        road
      end

      def background_asset_path
        @background_asset_path ||= @product.background_asset&.image&.path
      end

      def road_asset_path
        @road_asset_path ||= @product.road_asset&.image&.path
      end
    end
  end
end
