module V1
  module Users
    class Authenticate
      include Dry::Monads[:result, :do]
      include InteractionErrors
      class Contract < ::Validations::ApplicationContract
        params do
          required(:password).filled(:string)
          required(:password_confirmation).filled(:string)
        end

        rule(:password) do
          password_validation(self)
        end
      end

      def call(user, params)
        params = yield Contract.new.validate_params(params)
        unless params[:password] == params[:password_confirmation]
          return Failure(flow_error(message: I18n.t('custom_errors.different_password')))
        end

        unless user.authenticate(params[:password])
          return Failure(flow_error(message: I18n.t('custom_errors.wrong_password')))
        end

        Success()
      end
    end
  end
end
