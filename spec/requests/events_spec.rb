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

  it :new do
    get :new
    expect(response).to have_http_status(:success)
  end

  context 'при посещении детальной страницы' do
    it 'пользователь не может просматривать чужие события' do
      expect do
        get :show, params: { id: event.id }
      end.to raise_error(Pundit::NotAuthorizedError)
    end

    it 'пользователь может просматривать свои собственные события' do
      get :show, params: { id: event_own.id }
      expect(response).to have_http_status(:success)
    end
  end

  context 'при создании нового события' do
    it 'При создании события количество events-записей увеличивается на 1' do
      expect do
        post :create, params: { event: attributes_for(:event) }
      end.to change(Event, :count).by 1
    end

    it 'оно успешно создается и проиходит редирект' do
      post :create, params: { event: attributes_for(:event) }
      expect(response).to have_http_status(:redirect)
    end
  end
end
