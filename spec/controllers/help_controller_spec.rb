require 'rails_helper'

RSpec.describe HelpController, type: :controller do
  describe 'GET /help' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
