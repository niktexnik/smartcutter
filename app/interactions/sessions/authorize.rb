module Users
  module Sessions
    class Authorize
      include Dry::Monads[:result, :do]
      include DryInteractions::InteractionErrors

      def call(user, device, params)
        device.sms_confirmations.destroy_all
        device.update!(confirmed_at: Time.current,
                       fcm_token: params[:fcm_token].to_s.gsub(/\A'{1,2}\z|\A"{1,2}\z/, ''))
        session = new_session(device:, params: { ip: params[:ip], user_agent: params[:user_agent] })
        user.logout_all_user_sessions(session)
        Success(access_token: session.access_token, refresh_token: session.refresh_token)
      end

      private

      def new_session(device:, params:)
        device.create_new_session(ip: params[:ip])
      end
    end
  end
end
