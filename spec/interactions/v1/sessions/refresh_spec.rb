require 'rails_helper'

RSpec.describe V1::Sessions::Refresh do
  describe '#call' do
    include Dry::Monads[:result]

    subject { described_class.new.call(params) }

    let(:user) { create :user, :with_device }
    let(:current_session) { user.sessions.last }
    let(:params) { { ip: '127.0.0.1', refresh_token: current_session.refresh_token, identifier: 'test', platform: 'ios', app_version: '1.0.0' } }
    it 'refresh user token' do
      expect(subject.success).to be_truthy
      expect(user.sessions.size).to eq(2)
    end

    it 'returns failure if refresh token is not valid' do
      params[:refresh_token] = 'test'
      expect(subject.failure).to be_truthy
    end
  end
end
