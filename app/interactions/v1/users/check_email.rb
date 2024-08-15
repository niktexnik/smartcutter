module V1
  module Users
    class CheckEmail
      include Dry::Monads[:result, :do]
      include InteractionErrors
      class Contract < ::Validations::ApplicationContract
        params do
          required(:email).filled(:string)
        end
      end

      def call(params)
        params = yield Contract.new.validate_params(params)
        return Failure(flow_error(message: I18n.t('custom_errors.email_exists'))) if User.exists?(email: params[:email])

        Success()
      end
    end
  end
end
