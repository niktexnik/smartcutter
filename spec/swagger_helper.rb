require 'rails_helper'
require 'rswag_extensions/build_object_schema'

module SwaggerHelperExtensions
  def object_schema(fields)
    RswagExtensions::BuildObjectSchema.new.call(fields)
  end

  def request_body_schema(fields)
    parameter name: :request_body, in: :body, schema: object_schema(fields)
  end

  def request_form_schema(fields)
    fields.each do |key, value|
      parameter name: key, in: :formData, type: value, schema: object_schema(fields)
    end
  end

  def query_params_schema(fields)
    schema = object_schema(fields)

    schema[:properties].each do |name, attrs|
      parameter name:, in: :query, required: schema[:required].include?(name), **attrs
    end
  end

  def records_search_schema
    {
      page: { type: :integer, optional: true },
      limit: { type: :integer, optional: true }
    }
  end

  def response_schema(fields)
    schema object_schema(fields)
  end

  def swagger_tag(tag)
    metadata[:swagger_tag] = tag
  end

  def swagger_request_consumes(type)
    metadata[:swagger_request_consumes] = [type]
  end

  def swagger_request_produces(type)
    metadata[:swagger_request_produces] = [type]
  end
end

RSpec.configure do |config|
  config.extend SwaggerHelperExtensions

  config.before do |example|
    if (tag = example.metadata[:swagger_tag])
      example.metadata[:operation][:tags] ||= [tag]
    end

    example.metadata[:operation][:consumes] = example.metadata[:swagger_request_consumes] || ['application/json']
    example.metadata[:operation][:produces] = example.metadata[:swagger_request_produces] || ['application/json']
  end

  config.after do |example|
    type = response.headers['Content-Type']&.split(';')&.first || 'application/json'
    types = {
      'application/json' => -> { response.status == 204 ? '' : JSON.parse(response.body) },
      'application/xml' => -> { response.body },
      'application/pdf' => -> { '<PDF Content/>' },
      'text/html' => -> { response.body }
    }
    example.metadata[:response][:content] = { type => { example: types[type].call } }

    parameters = example.metadata[:operation][:parameters]
    request_body_param = parameters&.find { |param| param[:name] == :request_body }

    request_body_param[:schema][:example] ||= request_body if request_body_param && respond_to?(:request_body)
  end
end
