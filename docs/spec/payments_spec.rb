RSpec.describe 'SberPayments', type: :request do
  include StubResources::SberStub
  swagger_tag 'Оплата банковской картой'

  let(:user) { create(:user, :with_object) }
  let(:Bearer) { "Bearer #{user.sessions.last.access_token}" }

  before do
    sign_in(user)
  end

  path '/api/v1/objects/{object_id}/sber/payments' do
    parameter name: :object_id, type: :integer, in: :path

    post 'Оплатить' do
      before do
        stub_sber_register
      end

      request_body_schema(
        amount: {
          type: :integer,
          minimum: 1,
          maximum: 1.0e11.to_i
        }
      )
      let(:request_body) { { amount: 100_000 } }
      let(:object_id) { user_object.id }
      let(:user_object) { create :user_object }
      let!(:object_user_right) { create :object_user_right, user:, user_object: }

      response(200, 'success') do
        schema type: :object, properties: {
          order_id: { type: :string },
          form_url: { type: :string, format: :uri }
        }

        run_test!
      end
    end
  end

  path '/api/v1/sber/payments/callback' do
    parameter name: :orderId, type: :string, in: :query

    get 'Коллбэк сбербанка со статусом операции' do
      let(:order) { create(:sber_order, user:, user_object: user.objects.first) }
      let(:orderId) { order.sber_id }

      before do
        stub_sber_status(orderId)
      end

      response(200, 'success') do
        response_schema schemas.sber_order.to_props
        run_test!
      end
    end
  end
end
