require 'rails_helper'

RSpec.describe V1::Users::Profile::ChangeEmail do
  describe '#call' do
    include Dry::Monads[:result]
    subject { described_class.new.call(user, params) }
    let(:user) { create :user, :with_email_confirmation }

    context 'when success update' do
      let(:params) { { email: 'new_email@new.ru' } }
      it 'returns success' do
        expect(subject.success).to be_truthy
        user.email.should eq('new_email@new.ru')
        user.email_confirmed.should eq(false)
      end
    end

    context 'when user exists' do
      let(:params) { { email: user2.email } }
      let(:user) { create :user }
      let!(:user2) { create :user }
      it 'returns failure' do
        expect(subject.failure).to be_truthy
      end
    end
  end
end
