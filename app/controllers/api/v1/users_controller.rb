module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :authenticate_user, only: %i[authenticate]
      def create
        process_interaction_result(::V1::Users::Create.new.call(params)) do |result|
          render json: result
        end
      end

      def confirm_email
        process_interaction_result(::V1::Users::ConfirmEmail.new.call(params)) do |result|
          render json: result
        end
      end

      def authenticate
        process_interaction_result(::V1::Users::Authenticate.new.call(current_user, params)) do |_result|
          render_current_user
        end
      end

      def reset_password
        user = User.find_by!(email: params[:email])
        user.logout_all_user_sessions
        user.generate_reset_password_token
        user.reset_password_confirmations.last.send_confirmation_email
        head :no_content
      end

      def recovery_password_confirmation
        process_interaction_result(::V1::Users::RecoveryPasswordConfirmation.new.call(params)) do |_result|
          head :no_content
        end
      end

      def recovery_password
        process_interaction_result(::V1::Users::Profile::ChangePassword.new.call(params)) do |_result|
          head :no_content
        end
      end

      def check_email
        process_interaction_result(::V1::Users::CheckEmail.new.call(params)) do |result|
          render json: result
        end
      end
    end
  end
end
