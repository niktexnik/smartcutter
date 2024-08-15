module V1
  module Sessions
    class Login
      include Dry::Monads[:result, :do]
      include DryInteractions::InteractionErrors
      include InteractionErrors
      class Contract < ::Validations::ApplicationContract
        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
          required(:identifier).maybe(:string)
          required(:platform).maybe(:string)
          optional(:app_version).maybe(:string)
          optional(:ip).filled(:string)
        end
      end

      def call(params)
        params = yield Contract.new.validate_params(params)
        return email_error unless User.exists?(email: params[:email])

        user = authenticate(params)

        return password_error unless user

        device = device(user, params)

        session = device.create_new_session(ip: params[:ip])
        user.logout_all_user_sessions(session)

        Success(session)
      end

      private

      def authenticate(params)
        User.find_by(email: params[:email])&.authenticate(params[:password])
      end

      def email_error
        Failure(flow_error(message: I18n.t('dry_interaction.errors.validation_error'),
                           details: { email: I18n.t('custom_errors.email_not_found') }))
      end

      def password_error
        Failure(flow_error(message: I18n.t('dry_interaction.errors.validation_error'),
                           details: { password: I18n.t('custom_errors.invalid_credentials') }))
      end

      def device(user, params)
        record = Device.find_or_create_by(user:, identifier: params[:identifier], platform: params[:platform])
        record.update(app_version: params[:app_version])
        record
      end
    end
  end
end
