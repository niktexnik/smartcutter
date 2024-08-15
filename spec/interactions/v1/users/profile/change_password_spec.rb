require 'rails_helper'

RSpec.describe V1::Users::Profile::ChangePassword do
  describe '#call' do
    include Dry::Monads[:result]

    subject { described_class.new.call(params, user:) }

    let(:user) { create :user }

    context 'when user pass correct password' do
      let(:params) { { password: 'new_pass123!', password_confirmation: 'new_pass123!' } }
      it 'returns success' do
        expect(subject.success).to be_truthy
      end
    end

    context 'when user pass wrong password' do
      let(:params) { { password: 'wrong_pass123!', password_confirmation: 'new_pas23!' } }
      it 'returns success' do
        expect(subject.failure).to be_truthy
      end
    end
  end
end
