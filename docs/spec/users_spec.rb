RSpec.describe 'Users', type: :request do
  swagger_tag 'Пользователь'
  let(:user) { create(:user, :with_email_confirmation, :with_reset_password_confirmation) }
  let(:email_confirmation) { user.email_confirmations.last }
  let(:reset_password_token) { user.reset_password_confirmations.last.reset_token }

  path '/api/v1/users/' do
    post 'Создание пользователя' do
      description 'Создание нового пользователя'
      request_body_schema(email: { type: :string, optional: false },
                          password: { type: :string, optional: false },
                          agreement: { type: :boolean, optional: false },
                          platform: { type: :string, optional: false },
                          identifier: { type: :string, optional: false })

      let(:request_body) do
        { email: 'test@test.com', password: 'TestPassword1!', agreement: true, platform: 'ios', identifier: 'test' }
      end

      response(200, 'successful') do
        run_test!
      end
    end
  end

  path '/api/v1/users/confirm_email' do
    get 'Подтверждение почты' do
      parameter name: :confirmation_token, in: :query, required: true, type: :string
      response '200', 'valid token' do
        let(:confirmation_token) { email_confirmation.confirmation_token }

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/v1/users/recovery_password_confirmation' do
    get 'Восстановление пароля(подтверждение через почту)' do
      parameter name: :reset_password_token, in: :query, required: true, type: :string
      response '204', 'successfull' do
        run_test! do |response|
          expect(response.status).to eq(204)
        end
      end
    end
  end

  path '/api/v1/users/authenticate' do
    before { sign_in(user) }
    post 'Аутентификация пользователя' do
      description 'Аутентификация пользователя для совершения действий(изменения пароля, изменение почты)'
      request_body_schema(password: { type: :string, optional: false },
                          password_confirmation: { type: :string, optional: false })
      let(:user) { create(:user, :with_device) }
      let(:request_body) { { password: user.password, password_confirmation: user.password } }

      response(200, 'successful') do
        run_test!
        response_schema schemas.user.to_props
      end
    end
  end

  path '/api/v1/users/reset_password' do
    get 'Запрос на восстановление пароля' do
      parameter name: :email, in: :query, required: true, type: :string
      response '204', 'no content' do
        let(:email) { user.email }

        run_test! do |response|
          expect(response.status).to eq(204)
        end
      end
    end
  end

  path '/api/v1/users/recovery_password' do
    post 'Установка нового пароля' do
      request_body_schema(email: { type: :string, optional: false },
                          password: { type: :string, optional: false },
                          password_confirmation: { type: :string, optional: false })
      let(:request_body) do
        { email: user.email, password: 'MyPassword1212!', password_confirmation: 'MyPassword1212!' }
      end
      response '204', 'no content' do
        run_test! do |response|
          expect(response.status).to eq(204)
        end
      end
    end
  end

  path '/api/v1/users/check_email' do
    get 'Запрос на проверку наличия почты в системе' do
      parameter name: :email, in: :query, required: true, type: :string
      response '200', 'successfull' do
        let(:email) { 'asdas@asdas.ru' }

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
