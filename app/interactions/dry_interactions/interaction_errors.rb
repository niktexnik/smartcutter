module DryInteractions
  module InteractionErrors
    module_function

    Types = ::ConstantsDictionary.new(
      flow_error: 'FlowError',
      validation_error: 'Errors::InvalidRequestData'
    )

    def validation_error(details:, message: I18n.t('dry_interaction.errors.validation_error'))
      compose_interaction_error(message:, type: Types.validation_error, details:)
    end

    def flow_error(message:, details: {})
      compose_interaction_error(message:, type: Types.flow_error, details:)
    end

    def compose_interaction_error(message:, type:, details:)
      { message:, type:, details: }
    end
  end
end
