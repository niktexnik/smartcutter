module V1
  module Sessions
    class Refresh
      include Dry::Monads[:result, :do]
      include DryInteractions::InteractionErrors
      class Contract < ::Validations::ApplicationContract
        params do
          required(:refresh_token).filled(:string)
          required(:identifier).maybe(:string)
          optional(:app_version).maybe(:string)
          optional(:ip).maybe(:string)
        end
      end

      def call(params) # rubocop:disable Metrics/AbcSize
        params = yield Contract.new.validate_params(params)
        session = Session.refresh_token_active.find_by(refresh_token: params[:refresh_token])
        return Failure(message: I18n.t('custom_errors.invalid_refresh_token')) unless session

        user = session.user
        device = session.device
        session = device.create_new_session(ip: params[:ip])
        device.update!(identifier: params[:identifier], app_version: params[:app_version])
        user.logout_all_user_sessions(session)
        Success()
      end
    end
  end
end
