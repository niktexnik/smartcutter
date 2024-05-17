require 'rswag_extensions/schema_template'

module Docs
  module Schemas
    AutopaymentFull = RswagExtensions::SchemaTemplate.new(
      schema_name: 'AutopaymentFull',
      fields: {
        id: { type: :integer },
        object_user_right_id: { type: :integer },
        address: { type: :string },
        name: { type: :string },
        contract_number: { type: :string },
        amount_cents: { type: :integer, nullable: true },
        enabled: { type: :boolean },
        next_payment: { type: :string },
        object_id: { type: :integer, nullable: true }
      }
    )
  end
end
