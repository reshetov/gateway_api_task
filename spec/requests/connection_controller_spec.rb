require 'rails_helper'

RSpec.describe ConnectionsController, type: :controller do
  let!(:user) { create :user }
  let!(:connection) { create :connection }
  before { sign_in user }

  describe '#create' do
    subject { post :create }

    context 'with correct data' do
      before {
        body = {
          data: {
            redirect_url: 'http://www.com',
            connection_id: '111'
          }
        }

        stub_request(:post, 'https://www.saltedge.com/api/v5/oauth_providers/create').
          to_return(status: 200, body: body.to_json, headers: {})
      }

      it 'create new connection' do
        is_expected.to be_redirect
        expect(subject).to redirect_to('http://www.com')
        expect(flash[:alert]).to eq(nil)
      end
    end

    context 'with wrong data' do
      before {
        body = {
          error: 'Error'
        }

        stub_request(:post, 'https://www.saltedge.com/api/v5/oauth_providers/create').
          to_return(status: 400, body: body.to_json, headers: {})
      }

      it 'display error' do
        is_expected.to be_redirect
        expect(subject).to redirect_to(:root)
        expect(flash[:alert]).to eq('Error in connections#create: Error')
      end
    end
  end

  describe '#destroy' do
    subject { delete :destroy, params: { id: connection.id } }

    context 'with correct data' do
      before {
        body = {
          data: {
            removed: true,
            connection_id: connection.connection_id
          }
        }

        stub_request(:delete, "https://www.saltedge.com/api/v5/connections/#{connection.connection_id}").
          to_return(status: 200, body: body.to_json, headers: {})
      }

      it 'remove connection' do
        is_expected.to be_redirect
        expect(subject).to redirect_to(:root)
        expect(flash[:alert]).to eq(nil)
      end
    end

    context 'with wrong data' do
      before {
        body = {
          error: 'Error'
        }

        stub_request(:delete, "https://www.saltedge.com/api/v5/connections/#{connection.connection_id}").
          to_return(status: 404, body: body.to_json, headers: {})
      }

      it 'display error' do
        is_expected.to be_redirect
        expect(subject).to redirect_to(:root)
        expect(flash[:alert]).to eq('Error in connections#destroy: Error')
      end
    end
  end

  describe '#refresh' do
    subject { put :refresh, params: { id: connection.id } }

    context 'with correct data' do
      before {
        body = {
          data: {
            next_refresh_possible_at: nil,
            connection_id: connection.connection_id
          }
        }

        stub_request(:put, "https://www.saltedge.com/api/v5/connections/#{connection.connection_id}/refresh").
          to_return(status: 200, body: body.to_json, headers: {})
      }

      it 'remove connection' do
        is_expected.to be_redirect
        expect(subject).to redirect_to(:root)
        expect(flash[:alert]).to eq(nil)
      end
    end

    context 'with wrong data' do
      before {
        body = {
          error: 'Error'
        }

        stub_request(:put, "https://www.saltedge.com/api/v5/connections/#{connection.connection_id}/refresh").
          to_return(status: 406, body: body.to_json, headers: {})
      }

      it 'display error' do
        is_expected.to be_redirect
        expect(subject).to redirect_to(:root)
        expect(flash[:alert]).to eq('Error in connections#refresh: Error')
      end
    end
  end

  describe '#reconnect' do
    subject { patch :reconnect, params: { id: connection.id } }

    context 'with correct data' do
      before {
        body = {
          data: {
            redirect_url: 'http://reconnect.com',
            connection_id: '111'
          }
        }

        stub_request(:post, 'https://www.saltedge.com/api/v5/oauth_providers/reconnect').
          to_return(status: 200, body: body.to_json, headers: {})
      }

      it 'reconnect connection' do
        is_expected.to be_redirect
        expect(subject).to redirect_to('http://reconnect.com')
        expect(flash[:alert]).to eq(nil)
      end
    end

    context 'with wrong data' do
      before {
        body = {
          error: 'Error'
        }

        stub_request(:post, 'https://www.saltedge.com/api/v5/oauth_providers/reconnect').
          to_return(status: 406, body: body.to_json, headers: {})
      }

      it 'display error' do
        is_expected.to be_redirect
        expect(subject).to redirect_to(:root)
        expect(flash[:alert]).to eq('Error in connections#reconnect: Error')
      end
    end
  end

  describe '#callback' do
    subject { get :callback, params: params }

    context 'with correct data' do
      let(:params) { { uuid: connection.uuid } }

      before {
        body = {
          data: {
            connection_id: '111'
          }
        }

        stub_request(:put, 'https://www.saltedge.com/api/v5/oauth_providers/authorize').
          to_return(status: 200, body: body.to_json, headers: {})
      }

      it 'authorize connection' do
        is_expected.to be_redirect
        expect(subject).to redirect_to(:root)
        expect(flash[:alert]).to eq(nil)
      end
    end

    context 'with wrong data' do
      let(:params) { { uuid: connection.uuid, error: 'Error' } }

      it 'display error' do
        is_expected.to be_redirect
        expect(subject).to redirect_to(:root)
        expect(flash[:alert]).to eq('Error in connections#callback: Error')
      end
    end
  end
end
