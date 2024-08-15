require 'rswag_extensions/schema_template'

module Docs
  module Schemas
    User = RswagExtensions::SchemaTemplate.new(
      schema_name: 'User',
      fields: {
        id: :integer,
        email: :string,
        full_name: :string,
        phone: { type: :string, description: 'Формат номера 79xxxxxxxxx' },
        agreement: :boolean,
        email_confirmed: :boolean
      }
    )
  end
end
