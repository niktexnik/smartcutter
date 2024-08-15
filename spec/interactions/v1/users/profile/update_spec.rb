require 'rails_helper'

RSpec.describe V1::Users::Profile::Update do
  describe '#call' do
    include Dry::Monads[:result]

    subject { described_class.new.call(user, params) }

    let(:user) { create :user, email_confirmed: true }

    context 'when user update profile' do
      let(:params) do
        { first_name: 'first_name', last_name: 'last_name', middle_name: 'middle_name', phone: '79001112233' }
      end
      it 'returns success and user data will changed' do
        expect(subject.success).to be_truthy
        user.first_name.should eq('first_name')
        user.last_name.should eq('last_name')
        user.middle_name.should eq('middle_name')
        user.phone.should eq('79001112233')
      end
    end

    context 'when user update profile' do
      let!(:user2) { create :user }
      let(:params) do
        { first_name: 'first_name', last_name: 'last_name', middle_name: 'middle_name', phone: user2.phone }
      end
      it 'returns success and user data will changed' do
        expect(subject.failure).to be_truthy
      end
    end
  end
end
