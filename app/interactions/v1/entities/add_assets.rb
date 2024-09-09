module V1
  module Entities
    class AddAssets
      include Dry::Monads[:result, :do]
      include DryInteractions::InteractionErrors
      def call(entities)
        @mediaset = entities.first.mediaset
        start_process(entities)
        Success(@mediaset.entities)
      end

      private

      def start_process(entities)
        entities.each do |entity|
          add_road_asset(entity)
          add_background_asset(entity)
          add_watermark_asset(entity)
        end
      end

      def add_background_asset(entity)
        return unless @mediaset.background_asset

        Entities::Processing::AddBackgroundAsset.new.call(entity)
      end

      def add_road_asset(entity)
        return unless @mediaset.road_asset

        Entities::Processing::AddRoadAsset.new.call(entity)
      end

      def add_watermark_asset(entity)
        return unless @mediaset.watermark_asset

        Entities::Processing::AddWatermarkAsset.new.call(entity)
      end
    end
  end
end
