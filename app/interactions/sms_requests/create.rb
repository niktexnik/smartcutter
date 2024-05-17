module SmsRequests
  class Create
    include DryInteractions::InteractionErrors
    include Dry::Monads[:result, :do]

    def call(phone:, ip:)
      state = check_phone_spam(phone) ? :failed : :success
      request = SmsRequest.create!(phone:, state: SmsRequest::STATES[state], ip:)
      return Failure(flow_exception(exception_class: ::Errors::SmsSpam)) if request.state == SmsRequest::STATES[:failed]

      Success(request)
    end

    private

    def check_phone_spam(phone)
      requests_to_phone(phone).any?
    end

    def requests_to_phone(phone)
      SmsRequest.where(phone:, state: SmsRequest::STATES[:success])
                .where('created_at > ?', 1.minute.ago)
    end
  end
end
