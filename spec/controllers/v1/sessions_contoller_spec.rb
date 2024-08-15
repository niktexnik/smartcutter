require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :request do
  let(:user) { create(:user, :with_device) }

  describe '/api/v1/sessions/login' do
    it 'login' do
      post login_api_v1_sessions_path, params: { email: user.email,
                                                 password: user.password,
                                                 platform: 'ios',
                                                 identifier: 'test',
                                                 app_version: '1.0.0',
                                                 ip: '127.0.0.1' }

      expect(status).to eq(200)
    end
  end

  describe '/api/v1/sessions/current' do
    it 'current_session' do
      sign_in(user)
      get current_api_v1_sessions_path

      expect(status).to eq(200)
    end
  end

  describe '/api/v1/sessions/refresh_session' do
    it 'update access token' do
      sign_in(user)
      post refresh_session_api_v1_sessions_path, params: { refresh_token: user.sessions.last.refresh_token,
                                                           identifier: 'test',
                                                           platform: 'ios',
                                                           app_version: '1.0.0',
                                                           ip: '127.0.0.1' }

      expect(status).to eq(200)
    end
  end

  describe '/api/v1/sessions/logout' do
    it 'logout' do
      sign_in(user)
      delete logout_api_v1_sessions_path

      expect(status).to eq(204)
    end
  end
end
