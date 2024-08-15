module V1
  module Users
    class RecoveryPasswordConfirmation
      include Dry::Monads[:result, :do]
      include InteractionErrors
      class Contract < ::Validations::ApplicationContract
        params do
          required(:reset_password_token).filled(:string)
        end
      end

      def call(params)
        params = yield Contract.new.validate_params(params)
        confirmation = ::Users::ResetPasswordConfirmation.find_by(reset_token: params[:reset_password_token])

        return Failure(not_found_error) unless confirmation
        return Failure(flow_error(message: I18n.t('custom_errors.reset_token_expired'))) unless confirmation.reset_token_expires_at > Time.zone.now

        Success()
      end
    end
  end
end
