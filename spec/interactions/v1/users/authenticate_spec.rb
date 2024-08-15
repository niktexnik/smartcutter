require 'rails_helper'

RSpec.describe V1::Users::Authenticate do
  describe '#call' do
    include Dry::Monads[:result]

    subject { described_class.new.call(user, params) }

    let(:user) { create :user }

    context 'when user pass correct password' do
      let(:params) { { password: user.password, password_confirmation: user.password } }
      it 'returns success' do
        expect(subject.success).to be_truthy
      end
    end

    context 'when user pass wrong password' do
      let(:params) { { password: 'wrong_pass123!', password_confirmation: 'wrong_pass123!' } }
      it 'returns failure' do
        expect(subject.failure).to be_truthy
      end
    end
  end
end
