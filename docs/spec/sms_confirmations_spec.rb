RSpec.describe 'SmsConfirmation', type: :request do
  include StubResources::MtcStub

  swagger_tag 'Смс'

  let(:user) { create(:user) }

  path '/api/v1/sms_confirmations' do
    post 'Отправка смс кода для восстановления пароля' do
      let!(:sms_confirmation) { create :sms, user:, sms_code: SmsConfirmations::Send::TEST_SMS_CODE }
      let(:message) do
        I18n.t('sms_confirmations.sms_code_message', sms_code: sms_confirmation.sms_code)
      end
      let(:request_body) { { phone: user.phone } }

      before do
        allow(SmsConfirmation).to receive(:create!).and_return(sms_confirmation)
        stub_send_sms(user.phone, message)
      end

      request_body_schema(phone: :string)

      response(204, 'no_content') do
        run_test!
      end

      response(422, 'failure') do
        setup { sms_confirmation.update(created_at: Time.zone.now) }

        response_schema error: schemas.error_response
        run_test!
      end
    end
  end

  path '/api/v1/sms_confirmations/confirm' do
    let!(:sms) { create(:sms, user:) }

    post 'Подтверждение смс кода' do
      context 'success' do
        request_body_schema(sms_code: :string, phone: :string)

        let(:request_body) { { sms_code: sms.sms_code, phone: user.phone } }

        response(204, 'no_content') do
          run_test!
        end
      end

      context 'without phone' do
        request_body_schema(sms_code: :string, phone: :string)

        let(:request_body) { { sms_code: sms.sms_code } }

        response(422, 'failure') do
          response_schema error: schemas.error_response
          run_test!
        end
      end
    end
  end
end
