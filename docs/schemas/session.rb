require 'rswag_extensions/schema_template'

module Docs
  module Schemas
    Session = RswagExtensions::SchemaTemplate.new(
      schema_name: 'Session',
      fields: {
        access_token: :string,
        refresh_token: :string,
        access_token_expires_at: :datetime,
        refresh_token_expires_at: :datetime
      }
    )
  end
end
