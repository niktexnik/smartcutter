RSpec.describe 'Sessions', type: :request do
  swagger_tag 'Сессия'
  let(:user) { create(:user, :with_device) }

  path '/api/v1/sessions/login' do
    post 'Вход' do
      request_body_schema(email: { type: :string, optional: false },
                          password: { type: :string, optional: false },
                          platform: { type: :string, optional: false },
                          identifier: { type: :string, optional: false },
                          app_version: { type: :string, optional: true },
                          ip: { type: :string, optional: true })

      let(:request_body) do
        { email: user.email,
          password: user.password,
          platform: 'ios',
          identifier: 'test',
          app_version: '1.0.0',
          ip: '127.0.0.1' }
      end

      response(200, 'successful') do
        response_schema schemas.session.to_props
        run_test!
      end
    end
  end

  context 'Authorized users actions' do
    before { sign_in(user) }
    path '/api/v1/sessions/current' do
      get 'Текущая сессия' do
        setup { sign_in(user) }

        response(200, 'successful') do
          response_schema schemas.session.to_props
          run_test!
        end
      end
    end

    path '/api/v1/sessions/refresh_session' do
      post 'Обновление access_token' do
        context 'Authorized' do
          request_body_schema(refresh_token: { type: :string, optional: false },
                              identifier: { type: :string, optional: false },
                              platform: { type: :string, optional: false },
                              app_version: { type: :string, optional: true },
                              ip: { type: :string, optional: true })

          let(:request_body) do
            { refresh_token: user.sessions.last.refresh_token,
              identifier: 'test',
              platform: 'ios',
              app_version: '1.0.0',
              ip: '127.0.0.1' }
          end

          response(200, 'successful') do
            response_schema schemas.session.to_props
            run_test!
          end
        end
      end
    end

    path '/api/v1/sessions/logout' do
      delete 'Выход' do
        response(204, 'no content') do
          run_test!
        end
      end
    end
  end
end
