require_relative 'build_object_schema'

module RswagExtensions
  class SchemaTemplate
    attr_reader :schema_name

    def initialize(schema_name:, fields:)
      @schema_name = schema_name
      @schema = BuildObjectSchema.new.call(fields)
    end

    def to_h
      @schema
    end

    def array_of
      { type: :array, items: to_ref }
    end

    def to_ref
      { '$ref' => schema_ref }
    end

    def schema_ref
      "#/components/schemas/#{schema_name}"
    end

    def to_props
      @schema[:properties]
    end

    def exclude_props
      @schema[:properties].excluding(@schema[:properties].keys - @schema[:required])
    end
  end
end
