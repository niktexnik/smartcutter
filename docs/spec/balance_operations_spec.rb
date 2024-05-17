RSpec.describe 'Операции с балансом', type: :request do
  swagger_tag 'Операции с балансом'
  swagger_request_consumes 'text/csv'

  before { stub_1c_token_auth }

  path '/api/external/transactions' do
    parameter name: :request_body, in: :body, type: :string
    parameter name: 'Content-Type', in: :header, type: :string
    let(:request_body) { Rails.root.join('spec/fixtures/files/transactions.csv').binread }
    let(:'Content-Type') { 'text/csv' }

    post 'Создание 1С транзакций' do
      description 'Файл передается в теле запроса и принимается сервером как `text/csv`'

      response(204, 'no_content') do
        run_test!
      end
    end
  end

  path '/api/external/objects/balance' do
    parameter name: :request_body, in: :body, type: :string
    parameter name: 'Content-Type', in: :header, type: :string
    let(:request_body) { Rails.root.join('spec/fixtures/files/balance.csv').binread }
    let(:'Content-Type') { 'text/csv' }

    post 'Получение балансов из 1С' do
      description 'Файл передается в теле запроса и принимается сервером как `text/csv`'

      response(204, 'no_content') do
        run_test!
      end
    end
  end
end
