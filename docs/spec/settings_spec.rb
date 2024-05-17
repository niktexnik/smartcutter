RSpec.describe 'Settings', type: :request do
  swagger_tag 'Настройки'

  let(:user) { create :user }
  let(:Bearer) { user.sessions.last.access_token }

  before do
    create(:setting)
    sign_in(user)
  end

  path '/api/v1/settings' do
    get 'Получить настройки' do
      response(200, 'successful') do
        response_schema schemas.setting.to_props

        run_test!
      end
    end
  end
end
