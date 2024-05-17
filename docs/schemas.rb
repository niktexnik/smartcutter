module Docs
  module Schemas
    schema_names = Dir[Rails.root.join('docs/schemas/*.rb')].map do |file|
      require file
      File.basename(file, '.rb')
    end

    schemas = schema_names.index_with do |schema_name|
      const_get(schema_name.to_s.camelize, false)
    end

    All = ConstantsDictionary.new(schemas)
  end
end
