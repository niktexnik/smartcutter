module V1
  module Entities
    module Processing
      class OverlayEntity
        include Dry::Monads[:result, :do]
        include DryInteractions::InteractionErrors
        def call(mediaset)
          @mediaset = mediaset
          overlayed_asset = yield ::V1::Assets::OverlayBackgroundToRoad.new.call(product, settings)
          yield ::V1::Assets::OverlayAssetsToPhoto.new.call(overlayed_asset, entities, settings)
          Success()
        end

        private

        def settings
          @settings ||= product.products_setting
        end

        def product
          @product ||= @mediaset.product
        end

        def entities
          @entities ||= @mediaset.entities
        end
      end
    end
  end
end
