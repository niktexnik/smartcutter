module V1
  module Users
    module Profile
      class Update
        include Dry::Monads[:result, :do]
        include InteractionErrors
        class Contract < ::Validations::ApplicationContract
          params do
            optional(:first_name).filled(:string)
            optional(:middle_name).filled(:string)
            optional(:last_name).filled(:string)
            optional(:phone).filled(:string)
          end
        end

        def call(user, params)
          params = yield Contract.new.validate_params(params)
          if User.exists?(phone: params[:phone])
            return Failure(flow_error(message: I18n.t('custom_errors.phone_exists')))
          end

          user.update(params)

          Success()
        end
      end
    end
  end
end
