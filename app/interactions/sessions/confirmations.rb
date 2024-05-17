module Users
  module Sessions
    class Confirmation
      include Dry::Monads[:result, :do]
      include DryInteractions::InteractionErrors
      include DryValidations::Bannable
      include Antifraud::Eventable
      class Contract < ::Validations::ApplicationContract
        params do
          required(:phone).filled(:string)
          required(:identifier).filled(:string)
          required(:platform).filled(:string)
          required(:sms_code).filled(:string)
          optional(:ip).maybe(:string)
          optional(:fcm_token).maybe(:string)
        end

        rule(:phone) do
          match_regexp(self, /\A\d{10,16}\z/)
        end
      end

      def call(params)
        params = yield Contract.new.validate_params(params)
        user = User.find_by(phone: params[:phone])
        device = params[:user].present? ? Device.find_by(identifier: parms[:identifier], user:, platform: params[:platform]) : nil # rubocop:disable Layout/LineLength
        check_sms_code(params[:sms_code])
        device.update!(confirmed_at: Time.current)
        device.sms_confirmations.destroy_all
        Authorize.new.call(params[:user], params[:device], params)
      end

      private

      def check_sms_code(device, sms_code)
        model = device.sms_confirmations.last
        update_failure_sms_counter unless SmsConfirmations::ValidateCode.new.call(model, sms_code,
                                                                                  SmsConfirmation::MAX_SMS_ATTEMPS).success?
      end

      def update_failure_sms_counter
        user.increment(:count_of_failure_sms_confirmation)
        user.save
        Failure(flow_error(message: 'Something went wrong')) if user.count_of_failure_sms_confirmation == 3
      end
    end
  end
end
