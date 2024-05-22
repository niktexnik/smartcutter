module Entities
  class Create
    def call(mediaset)
      @patterns = mediaset.product.patterns
      create_entities(mediaset)
    end

    private

    def create_entities(mediaset)
      @patterns.each_with_index do |pattern, i|
        mediaset.entities.create(name: mediaset.name + i, pattern:, state: :empty, position: i)
      end
    end
  end
end
