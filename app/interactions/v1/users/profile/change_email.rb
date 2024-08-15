module V1
  module Users
    module Profile
      class ChangeEmail
        include Dry::Monads[:result, :do]
        include InteractionErrors
        class Contract < ::Validations::ApplicationContract
          params do
            required(:email).filled(:string)
          end

          rule :email do
            key.failure(:record_exists?) if User.exists?(email: value)
            email_validation(self)
          end
        end

        def call(user, params)
          params = yield Contract.new.validate_params(params)

          reset_email(user, params[:email])
          Success()
        end

        private

        def reset_email(user, email)
          user.update(email_confirmed: false, email:)
          user.generate_email_confirmation_token
          user.email_confirmations.last.send_confirmation_email
        end
      end
    end
  end
end
