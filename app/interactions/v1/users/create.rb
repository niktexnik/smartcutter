module V1
  module Users
    class Create
      include Dry::Monads[:result, :do]
      include DryInteractions::InteractionErrors
      class Contract < ::Validations::ApplicationContract
        params do
          required(:email).filled(:bool)
          required(:password).filled(:string)
          required(:identifier).filled(:string)
          required(:agreement).filled(:bool)
          required(:platform).filled(:string)
          optional(:phone).filled(:string)
          optional(:first_name).filled(:string)
          optional(:middle_name).filled(:string)
          optional(:last_name).filled(:string)
          optional(:ip).filled(:string)
          optional(:email).filled(:string)
          optional(:app_version).filled(:string)
        end

        rule(:email) do
          email_validation(self)
        end

        rule(:password) do
          password_validation(self)
        end

        rule(:phone) do
          match_regexp(self, /\A\d{10,16}\z/) if value
        end

        rule(:agreement) do
          key.failure(:tos_accepted?) unless value
        end
      end

      def call(params)
        params = yield Contract.new.validate_params(params)
        yield Users::CheckEmail.new.call(params)
        user = create_user(params)
        create_device(user, params)
        Success(user)
      end

      private

      def create_user(params)
        User.create(params.slice(:email, :password, :agreement))
      end

      def create_device(user, params)
        Device.create(identifier: params[:identifier], user:, platform: params[:platform],
                      app_version: params[:app_version])
      end
    end
  end
end
