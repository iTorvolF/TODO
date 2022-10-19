require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:event_own) { create(:event, user: user) }

  before { sign_in(user) }

  it :index do
    get :index
    expect(response).to have_http_status(:success)
  end
end
