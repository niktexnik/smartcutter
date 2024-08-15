require 'rails_helper'

RSpec.describe Api::V1::Users::ProfileController, type: :request do
  let(:user) { create(:user, :with_device) }

  before { sign_in(user) }

  describe 'GET /api/v1/users/profile' do
    it 'shows user profile info' do
      get api_v1_profile_index_path

      expect(response.status).to eq(200)
    end
  end

  describe 'PUT /api/v1/users/profile' do
    it 'updates user profile info' do
      put api_v1_profile_index_path,
          params: { first_name: 'first_name', last_name: 'last_name', middle_name: 'middle_name',
                    phone: '79001112233' }

      expect(response.status).to eq(200)
      user.reload
      user.first_name.should eq('first_name')
      user.last_name.should eq('last_name')
      user.middle_name.should eq('middle_name')
      user.phone.should eq('79001112233')
    end
  end

  describe 'PATCH /api/v1/users/profile/change_password' do
    it 'updates user password' do
      patch change_password_api_v1_profile_index_path(password: 'Newpassword11!',
                                                      password_confirmation: 'Newpassword11!')

      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH /api/v1/users/profile/change_email' do
    it 'updates user email' do
      patch change_email_api_v1_profile_index_path, params: { email: 'test@test22.ru' }
      expect(response.status).to eq(200)
      user.reload
      user.email.should eq('test@test22.ru')
    end
  end

  describe 'DELETE /api/v1/users/profile' do
    it 'shows user profile info' do
      delete api_v1_profile_index_path

      expect(response.status).to eq(204)
    end
  end
end
