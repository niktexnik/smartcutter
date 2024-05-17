require 'swagger_helper'
require_relative 'schemas'

module SchemasHelpers
  def schemas
    Docs::Schemas::All
  end

  def error_response_schema
    response_schema error: schemas.error
  end
end

RSpec.configure do |config|
  config.extend SchemasHelpers
  config.swagger_root = Rails.public_path.join('docs').to_s

  config.swagger_docs = {
    'swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Smartcutter',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://smartcutter.ru/'
        }
      ],
      components: {
        schemas: Docs::Schemas::All.values.each_with_object({}) do |schema, result|
          result[schema.schema_name] = schema.to_h
        end,
        securitySchemes: {
          Bearer: {
            type: :apiKey,
            name: 'Authorization',
            in: :headers
          }
        }
      }
    }
  }

  config.swagger_format = :yaml
end
