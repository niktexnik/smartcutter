module DryInteractions
  module MonadResult
    class InteractionError < StandardError; end

    module_function

    def extract_success!(result)
      result.either(
        ->(success) { success },
        ->(failure) { raise_interaction_error!(failure) }
      )
    end

    def raise_interaction_error!(error)
      raise InteractionError, error
    end
  end
end
