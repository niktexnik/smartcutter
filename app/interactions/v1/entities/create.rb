module V1
  module Entities
    class Create
      def call(mediaset)
        @mediaset = mediaset
        create_entities
      end

      private

      def create_entities
        patterns.each_with_index do |pattern, i|
          mediaset.entities.create(name: mediaset.name + i, pattern:, state: :empty, position: i)
        end
      end

      def patterns
        @patterns ||= Pattern.where(id: product.pattern_ids)
      end

      def product
        @product ||= @mediaset.product
      end
    end
  end
end
