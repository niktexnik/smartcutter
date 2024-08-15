require 'rails_helper'

RSpec.describe V1::Users::RecoveryPasswordConfirmation do
  describe '#call' do
    include Dry::Monads[:result]

    subject { described_class.new.call(params) }

    let(:user) { create :user, :with_reset_password_confirmation }
    let(:reset_password_token) { user.reset_password_confirmations.last.reset_token }

    context 'when user confirm email' do
      let(:params) { { reset_password_token: } }
      it 'returns success if reset password token is valid' do
        user.generate_reset_password_token
        expect(subject.success).to be_truthy
      end

      it 'returns failure if reset password token is not valid' do
        params[:reset_password_token] = 'test'
        expect(subject.failure).to be_truthy
      end
    end
  end
end
