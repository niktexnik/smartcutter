module Interactionable
  extend ActiveSupport::Concern

  included do
    private

    def process_dry_monad_result(result)
      result.either(
        ->(success) { yield success },
        ->(failure) { render json: { error: failure }, status: :bad_request }
      )
    end
  end
end
