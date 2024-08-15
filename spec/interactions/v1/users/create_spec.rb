require 'rails_helper'

RSpec.describe V1::Users::Create do
  describe '#call' do
    include Dry::Monads[:result]

    subject { described_class.new.call(params) }

    let(:user) { create :user }

    context 'when register new user' do
      let(:params) do
        { email: 'test@test.com',
          password: 'Test1234!',
          agreement: true,
          identifier: 'test',
          platform: 'ios',
          app_version: '1.0.0',
          ip: '127.0.0.1' }
      end
      it 'returns failure if password is not valid' do
        params[:password] = '123'
        expect(subject.failure).to be_truthy
      end

      it 'returns success if password is valid' do
        expect(subject.success).to be_truthy
      end

      it 'returns failure if tos not accepted' do
        params[:agreement] = false
        expect(subject.failure).to be_truthy
      end

      it 'creates new user with valid email and email was downcased' do
        params[:email] = 'TEST@test.com'
        expect(subject.success).to be_truthy
        expect(User.last.email).to eq(params[:email].downcase)
      end
    end

    context 'when send duplicate email' do
      let(:params) { { password: 'Test1234!', agreement: true, email: user.email } }

      it 'returns failure if email already exists' do
        expect(subject.failure).to be_truthy
      end
    end
  end
end
