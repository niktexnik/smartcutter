require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) { create(:user, :with_device, :with_email_confirmation, :with_reset_password_confirmation) }
  let(:email_confirmation) { user.email_confirmations.last }
  let(:reset_password_token) { user.reset_password_confirmations.last.reset_token }

  describe '/api/v1/users' do
    it 'returns failure if email exists' do
      post api_v1_users_path, params: { email: user.email, agreement: true, password: 'test12345!' }

      expect(status).to eq(422)
    end

    it 'create user successfully' do
      post api_v1_users_path, params: { email: 'test@test.ru',
                                        password: 'test12345!',
                                        agreement: true,
                                        platform: 'ios',
                                        identifier: 'test' }
      expect(status).to eq(200)
    end

    it 'not create user' do
      post api_v1_users_path, params: { email: 'test@test.ru',
                                        password: 'test12345!',
                                        agreement: false }

      expect(status).to eq(422)
    end
  end

  describe '/api/v1/users/confirm_email' do
    it 'confirmed email' do
      get confirm_email_api_v1_users_path(confirmation_token: email_confirmation.confirmation_token)

      expect(status).to eq(200)
    end

    it 'not confirmed email' do
      get confirm_email_api_v1_users_path(confirmation_token: 'test1')

      expect(status).to eq(404)
    end
  end

  describe '/api/v1/users/authenticate' do
    it 'return success when pass right password' do
      sign_in(user)
      post authenticate_api_v1_users_path(password: user.password, password_confirmation: user.password)

      expect(status).to eq(200)
    end

    it 'return failure when pass wrong password confirmation' do
      post authenticate_api_v1_users_path(password: user.password, password_confirmation: 'wrongPass!')

      expect(status).to eq(401)
    end
  end

  describe '/api/v1/users/reset_password' do
    it 'return success' do
      get reset_password_api_v1_users_path(email: user.email)
      expect(status).to eq(204)
    end
  end

  describe '/api/v1/users/recovery_password' do
    it 'return success' do
      post recovery_password_api_v1_users_path(email: user.email, password: 'test12345!',
                                               password_confirmation: 'test12345!')
      expect(status).to eq(204)
    end
  end

  describe '/api/v1/users/recovery_password_confirmation' do
    it 'return success' do
      get recovery_password_confirmation_api_v1_users_path(reset_password_token:)
      expect(status).to eq(204)
    end
  end

  describe '/api/v1/users/check_email' do
    it 'return success' do
      get check_email_api_v1_users_path(email: 'test20@ya.ru')
      expect(status).to eq(200)
    end

    it 'return failure' do
      get check_email_api_v1_users_path(email: user.email)
      expect(status).to eq(422)
    end
  end
end
