module Users
  class Create
    include Dry::Monads[:result, :do]
    include DryInteractions::InteractionErrors
    class Contract < ::Validations::ApplicationContract
      params do
        required(:phone).filled(:string)
        required(:identifier).filled(:string)
        required(:platform).filled(:string)
        optional(:name).filled(:string)
        optional(:middle_name).filled(:string)
        optional(:surname).filled(:string)
        optional(:ip).filled(:string)
        optional(:email).filled(:string)
        optional(:app_version).filled(:string)
      end

      rule(:email) do
        email_validation(self)
      end
      rule(:phone) do
        match_regexp(self, /\A\d{10,16}\z/)
      end
    end

    def call(params)
      params = yield Contract.new.validate_params(params)
      user = find_or_create_user(params)
      device = find_device(user, params)
      update_device(device, params)

      yield SmsRequests::Create.new.call(phone: params[:phone], ip: params[:ip])
      SmsConfirmations::SendCode.new.call(user, device)
      Success(device)
    end

    private

    def update_device(device, params)
      device.update!(update_device_params(params))
      device.close_all_sessisons
      device.save
    end

    def find_or_create_user(params)
      @find_or_create_user ||= begin
        user = User.create_with(params.slice(:name, :middle_name, :surname, :email))
                   .find_or_create_by(phone: params[:phone])
        user
      end
    end

    def find_device(user, params)
      device = Device.find_or_initialize_by(identifier: params[:identifier], user:, platform: params[:platform])
      device.save
      device
    end

    def update_device_params(params)
      update_params = { confirmed_at: nil, updated_at: Time.zone.now }
      update_params[:app_version] = params[:app_version] if params[:app_version].present?
      update_params
    end
  end
end
