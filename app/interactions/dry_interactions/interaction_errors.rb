module DryInteractions
  module InteractionErrors
    TYPES = ConstantsDictionary.from_array(%i[flow_error
                                              validation_error
                                              bad_request_error
                                              authentication_error
                                              authorization_error
                                              unprocessable_entity_error
                                              not_found_error])

    module_function

    def http_status(error)
      {
        TYPES.bad_request_error => 400,
        TYPES.authentication_error => 401,
        TYPES.authorization_error => 403,
        TYPES.not_found_error => 404,
        TYPES.unprocessable_entity_error => 422
      }.fetch(error[:type], 422)
    end

    def validation_error(details:, message: error_message(:validation_error))
      interaction_error(message:, details:, type: TYPES.validation_error)
    end

    def flow_error(message:, details: {})
      interaction_error(message:, details:, type: TYPES.flow_error)
    end

    [TYPES.authentication_error, TYPES.not_found_error, TYPES.authorization_error].each do |error_type|
      define_method(error_type) do |message: error_message(error_type)|
        interaction_error(message:, details: {}, type: error_type)
      end
    end

    def interaction_error(message:, details:, type:)
      { message:, details:, type: }
    end

    def error_message(slug)
      I18n.t(slug, scope: 'interaction_errors.error_messages')
    end
  end
end
