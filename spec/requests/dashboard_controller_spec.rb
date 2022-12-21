require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let!(:user) { create :user }
  before { sign_in user }

  describe '#index' do
    subject { get :index }

    it 'assigns correct data' do
      is_expected.to be_successful
      expect(controller.current_user).to eq(user)
    end
  end
end
