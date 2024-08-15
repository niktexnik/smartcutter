module Renderable
  extend ActiveSupport::Concern

  included do
    private

    # rubocop:disable Style/ExplicitBlockArgument
    def process_interaction_result(result)
      result.either(
        ->(data) { yield data },
        ->(failure) { render_interaction_error(failure) }
      )
    end
    # rubocop:enable Style/ExplicitBlockArgument

    def render_interaction_error(error)
      logger.info(error)
      render json: { error: }, status: InteractionErrors.http_status(error)
    end

    def authenticate_user
      render_interaction_error(InteractionErrors.authentication_error) unless current_user
    end
  end
end
