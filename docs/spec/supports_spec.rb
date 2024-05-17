RSpec.describe 'Support', type: :request do
  swagger_tag 'Обращения пользователей'

  let(:user) { create(:user, :with_object) }
  let(:Bearer) { user.sessions.last.access_token }

  before do
    create(:setting)
    sign_in(user)
  end

  path '/api/v1/supports/payment' do
    post 'Ошибка при оплате' do
      let(:order) { create(:sber_order, user:, user_object: user.objects.first) }

      request_body_schema(order_id: :integer)

      let(:request_body) { { order_id: order.sber_id } }
      response(204, 'no_content') do
        run_test!
      end
    end
  end
end
