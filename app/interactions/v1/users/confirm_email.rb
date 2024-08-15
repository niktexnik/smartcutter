module V1
  module Users
    class ConfirmEmail
      include Dry::Monads[:result, :do]
      include InteractionErrors
      class Contract < ::Validations::ApplicationContract
        params do
          required(:confirmation_token).filled(:string)
        end
      end

      def call(params)
        params = yield Contract.new.validate_params(params)
        confirmation = ::Users::EmailConfirmation.find_by(confirmation_token: params[:confirmation_token])
        return Failure(not_found_error) unless confirmation

        user = confirmation&.user

        Success(user.update(email_confirmed: true))
      end
    end
  end
end
