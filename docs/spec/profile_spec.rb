RSpec.describe 'Profile', type: :request do
  swagger_tag 'Профиль пользователя'

  let!(:user) { create(:user, :with_device) }

  before { sign_in(user) }

  path '/api/v1/users/profile' do
    get 'Отображает профиль пользователя' do
      response '200', 'successful' do
        response_schema schemas.user.to_props
        run_test!
      end
    end
  end

  path '/api/v1/users/profile' do
    put 'Обновление профиля пользователя' do
      request_body_schema(first_name: { type: :string, optional: true },
                          middle_name: { type: :string, optional: true },
                          last_name: { type: :string, optional: true })

      let(:request_body) do
        { first_name: 'Тест',
          last_name: 'Тестовичус ',
          middle_name: 'Тестович ' }
      end
      response '200', 'successful' do
        response_schema schemas.user.to_props
        run_test!
      end
    end
  end

  path '/api/v1/users/profile/change_password' do
    patch 'Обновление пароля' do
      request_body_schema(password: { type: :string, optional: false },
                          password_confirmation: { type: :string, optional: false })
      let(:request_body) do
        { password: 'new_password21!',
          password_confirmation: 'new_password21!' }
      end
      response '200', 'successful' do
        response_schema schemas.user.to_props
        run_test!
      end
    end
  end

  path '/api/v1/users/profile/change_email' do
    patch 'Обновление эмэйла' do
      request_body_schema(email: { type: :string, optional: false })
      let(:request_body) { { email: 'test@tres.ru' } }
      response '200', 'no content' do
        response_schema schemas.user.to_props
        run_test!
      end
    end
  end

  # path '/api/v1/users/profile/change_avatar' do
  #   patch 'Обновление или создание аватара' do
  #     swagger_request_consumes 'multipart/form-data'
  #     request_form_schema(file: :file)
  #     let(:request_body) { { file: } }
  #     response '200', 'successful' do
  #       run_test!
  #     end
  #   end
  # end

  path '/api/v1/users/profile/' do
    delete 'Удаление профиля пользователя' do
      response '204', 'successful' do
        run_test!
      end
    end
  end
end
