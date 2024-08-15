module V1
  module Users
    module Profile
      class ChangePassword
        include Dry::Monads[:result, :do]
        include InteractionErrors
        class Contract < ::Validations::ApplicationContract
          params do
            optional(:email).filled(:string)
            required(:password).filled(:string)
            required(:password_confirmation).filled(:string)
          end

          rule :password do
            password_validation(self)
          end
        end

        def call(params, user: nil)
          params = yield Contract.new.validate_params(params)
          user ||= User.find_by(email: params[:email])
          return Failure(not_found_error) unless user
          return Failure(flow_error(message: I18n.t('custom_errors.wrong_password'))) if params[:password] != params[:password_confirmation]

          user.update(password: params[:password])
          Success()
        end
      end
    end
  end
end
