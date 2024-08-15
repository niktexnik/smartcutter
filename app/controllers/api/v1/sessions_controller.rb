module Api
  module V1
    class SessionsController < Api::V1::ApiController
      before_action :authenticate_user, only: %i[current refresh_session logout]
      def login
        process_interaction_result(::V1::Sessions::Login.new.call(params)) do |session|
          render json: session
        end
      end

      def current
        render_current_session
      end

      def refresh_session
        return render_interaction_error(InteractionErrors.authentication_error) if current_session.blank?

        process_interaction_result(::V1::Sessions::Refresh.new.call(params)) do |_session|
          render_current_session
        end
      end

      def logout
        return render_interaction_error(InteractionErrors.authentication_error) if current_session.blank?

        current_session.logout
        head :no_content
      end
    end
  end
end
