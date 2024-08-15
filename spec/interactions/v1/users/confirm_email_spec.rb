require 'rails_helper'

RSpec.describe V1::Users::ConfirmEmail do
  describe '#call' do
    include Dry::Monads[:result]

    subject { described_class.new.call(params) }

    let(:user) { create :user, email_confirmed: false }
    let(:email_confirmation) { create :email_confirmation, user: }

    context 'when user confirm email' do
      let(:params) { { confirmation_token: user.email_confirmations.last.confirmation_token } }
      it 'returns failure if password is not valid' do
        expect(subject.success).to be_truthy
      end

      it 'returns failure if password is not valid' do
        params[:confirmation_token] = 'test'
        expect(subject.failure).to be_truthy
      end
    end
  end
end
