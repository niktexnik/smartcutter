module V1
  module Entities
    class AddAssets
      include Dry::Monads[:result, :do]
      include DryInteractions::InteractionErrors
      def call(entities)
        @mediaset = entities.first.mediaset
        start_process(entities)
        Success()
      end

      private

      def start_process(entities)
        entities.each do |entity|
          Entities::Processing::AddRoadAsset.new.call(entity, settings) if @mediaset.road_asset
          Entities::Processing::AddBackgroundAsset.new.call(entity, settings) if @mediaset.background_asset
          Entities::Processing::AddWatermarkAsset.new.call(entity, settings) if @mediaset.watermark_asset
        end
      end

      def settings
        @settings ||= @mediaset.product.products_setting
      end
    end
  end
end
