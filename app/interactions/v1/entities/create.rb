module V1
  module Entities
    class Create
      def call(mediaset)
        define_variables(mediaset)
        create_entities(mediaset)
        bind_assets(mediaset)
      end

      private

      def define_variables(mediaset)
        @patterns = mediaset.product.patterns
        @assets = mediaset.assets
        @entities = mediaset.entities.order(:position)
      end

      def create_entities(mediaset)
        @patterns.each_with_index do |pattern, i|
          mediaset.entities.create(name: mediaset.name + i, pattern:, state: :empty, position: i)
        end
      end

      def bind_assets(mediaset)
        @entities.each do |entity|
          entity.update(asset_id: mediaset.assets.find(entity.pattern.asset_id))
        end
      end
    end
  end
end
