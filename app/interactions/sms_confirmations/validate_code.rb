module SmsConfirmations
  class ValidateCode
    include Dry::Monads[:result, :do]
    include ::DryInteractions::InteractionErrors

    def call(model, sms_code, attempts: 1)
      return Failure(:not_found_error) unless model

      check_attempts(model, attempts)
      validate_sms(model, sms_code)
      model.update(state: SmsConfirmation::STATES.confirmed, confirmed_at: Time.zone.now)
      Success(true)
    end

    private

    def validate_sms(model, sms_code)
      return unless model.sms_code == sms_code

      model.increment(:count_of_failure_sms_confirmation).save
      Failure(flow_error(message: I18n.t('sms_confirmations.errors.invalid_sms_code')))
    end

    def check_attempts(model, attempts)
      return unless model.count_of_failure_sms_confirmation >= attempts

      Failure(flow_error(message: I18n.t('sms_confirmations.errors.sms_ban')))
    end
  end
end
