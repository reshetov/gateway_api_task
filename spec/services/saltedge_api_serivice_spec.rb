require 'rails_helper'

describe SaltedgeApiService, type: :service do
  before {
    stub_const('ENV', {
                        'SALTEDGE_URL' => 'https://www.saltedge.com/api/v5',
                        'SALTEDGE_APP_ID' => 'api_id',
                        'SALTEDGE_SECRET' => 'secret',
                        'SALTEDGE_PRIVATE_KEY' => 'private.pem',
                        'DEFAULT_URL_HOST' => 'http://test.domain'
                      }
    )
  }

  let!(:user) { create :user }
  let!(:connection) { create :connection }
  let!(:account) { create :account }
  let!(:api_instance) { SaltedgeApiService.new }

  describe '#request' do
    subject { api_instance.request(method, path, payload) }

    let(:method) { action.send(:url_data)[:method] }
    let(:path) { action.send(:url_data)[:path] }
    let(:payload) { action.send(:payload) }

    context 'create customer' do
      before {
        stub_request(:post, 'https://www.saltedge.com/api/v5/customers').
          to_return(status: 200, body: { data: { customer: '...'} }.to_json, headers: {})
      }

      let(:action) { ApiActions::CreateCustomerAction.new(user: user) }

      it 'return customer data' do
        is_expected.to eq([200, { 'customer' => '...' }])
      end
    end

    context 'create connection' do
      before {
        stub_request(:post, 'https://www.saltedge.com/api/v5/oauth_providers/create').
          to_return(status: 200, body: { data: { connection: '...'} }.to_json, headers: {})
      }

      let(:action) { ApiActions::CreateConnectionAction.new(user: user, uuid: connection.uuid) }

      it 'return connection data' do
        is_expected.to eq([200, { 'connection' => '...' }])
      end
    end

    context 'authorize' do
      before {
        stub_request(:put, 'https://www.saltedge.com/api/v5/oauth_providers/authorize').
          to_return(status: 200, body: { data: { authorized: '...'} }.to_json, headers: {})
      }

      let(:action) { ApiActions::AuthorizeConnectionAction.new(connection: connection, auth_params: {}) }

      it 'return authorized data' do
        is_expected.to eq([200, { 'authorized' => '...' }])
      end
    end

    context 'destroy connection' do
      before {
        stub_request(:delete, "https://www.saltedge.com/api/v5/connections/#{connection.connection_id}").
          to_return(status: 200, body: { data: { removed: '...'} }.to_json, headers: {})
      }

      let(:action) { ApiActions::DestroyConnectionAction.new(connection: connection) }

      it 'return removed data' do
        is_expected.to eq([200, { 'removed' => '...' }])
      end
    end

    context 'fetch accounts' do
      before {
        stub_request(:get, 'https://www.saltedge.com/api/v5/accounts').
          to_return(status: 200, body: { data: { accounts: '...'} }.to_json, headers: {})
      }

      let(:action) { ApiActions::FetchAccountsAction.new(connection: connection) }

      it 'return accounts data' do
        is_expected.to eq([200, { 'accounts' => '...' }])
      end
    end

    context 'fetch transactions' do
      before {
        stub_request(:get, 'https://www.saltedge.com/api/v5/transactions').
          to_return(status: 200, body: { data: { transactions: '...'} }.to_json, headers: {})
      }

      let(:action) { ApiActions::FetchTransactionsAction.new(account: account) }

      it 'return transactions data' do
        is_expected.to eq([200, { 'transactions' => '...' }])
      end
    end
  end
end
