module RswagExtensions
  class BuildObjectSchema
    Field = Struct.new(:name, :properties, keyword_init: true)

    def initialize(nullable: false)
      @nullable = nullable
    end

    def call(fields)
      parsed_fields = fields.map do |name, opts|
        Field.new(name:, properties: field_properties(opts))
      end

      {
        type: :object,
        nullable: @nullable,
        properties: collect_properties(parsed_fields),
        required: collect_required_fields(parsed_fields)
      }
    end

    private

    def collect_properties(fields)
      fields.each_with_object({}) do |field, result|
        result[field.name] = field.properties.except(:optional)
      end
    end

    def collect_required_fields(fields)
      fields.each_with_object([]) do |field, result|
        result.push(field.name) unless field.properties[:optional]
      end
    end

    def field_properties(opts_or_type)
      if opts_or_type.is_a?(Hash)
        opts_or_type
      elsif opts_or_type.respond_to?(:to_ref)
        opts_or_type.to_ref
      else
        { type: opts_or_type }
      end
    end
  end
end
