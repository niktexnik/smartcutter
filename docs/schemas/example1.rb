require 'rswag_extensions/schema_template'
require_relative 'user'
require_relative 'user_section'

module Docs
  module Schemas
    EnabledState = RswagExtensions::SchemaTemplate.new(
      schema_name: 'EnabledState',
      fields: {
        id: :integer,
        states: { type: :array, items: { type: :string }, nullable: true, description: EnabledState::STATES },
        section: { '$ref': UserSection.schema_ref, nullable: false }
      }
    )
  end
end
