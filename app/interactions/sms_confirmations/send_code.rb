module SmsConfirmations
  class SendCode
    include Dry::Monads[:result, :do]
    include ::DryInteractions::InteractionErrors

    def call(user, device)
    end

    private
  end
end
