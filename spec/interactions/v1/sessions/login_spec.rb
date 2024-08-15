require 'rails_helper'

RSpec.describe V1::Sessions::Login do
  describe '#call' do
    include Dry::Monads[:result]

    subject { described_class.new.call(params) }

    let(:user) { create :user, password: '1234' }
    let(:params) { { ip: '127.0.0.1', platform: 'ios', app_version: '1.2.3', email: user.email, password: '1234', identifier: 'test' } }
    it 'create user session and device' do
      expect(subject.success).to be_truthy
      expect(user.sessions.size).to eq(1)
      expect(user.devices.size).to eq(1)
      expect(user.devices.last.platform).to eq('ios')
    end
  end
end
