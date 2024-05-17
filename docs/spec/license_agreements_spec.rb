require 'swagger_helper'

RSpec.describe 'Лицензионное соглашение', type: :request do
  swagger_tag 'Лицензионное соглашение'

  let(:current_user) { create(:user) }
  let(:license_agreement) { create(:license_agreement) }

  before do
    sign_in(current_user)
    license_agreement
  end

  path '/api/v1/license_agreements/preview' do
    get('Просмотр лицензионного соглашения') do
      response(200, 'successful') do
        response_schema schemas.license_agreement.to_props
        run_test!
      end
    end
  end

  path '/api/v1/license_agreements/agree' do
    get('Согласиться с лицензионным соглашением') do
      response(204, 'no_content') do
        run_test!
      end
    end
  end
end
