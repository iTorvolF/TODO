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

  context 'создании нового события' do
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

  context 'удаление событий' do
    it 'Событие успешно удаляется' do
      expect do
        delete :destroy, params: { id: event_own.id }
        expect(response).to have_http_status(:redirect)
      end
    end

    it 'нельзя удалять чужие события' do
      expect do
        delete :destroy, params: { id: event.id }
      end.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'редактирование событий' do
    it 'пользователь может редактировать свои собственные события' do
      get :edit, params: { id: event_own.id }
      expect(response).to have_http_status(:success)
    end

    it 'пользователь не может редактировать чужие события' do
      expect do
        get :edit, params: { id: event.id }
      end.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'обновление событий' do
    it 'пользователь может обновлять свои собственные события' do
      patch :update, params: { id: event_own.id, event: attributes_for(:event) }
      expect(response).to have_http_status(:redirect)
    end

    it 'нельзя обновлять чужие события' do
      patch :update, params: { id: event_own.id, event: attributes_for(:event_wrong) }
      expect(response).respond_to? :missing
    end
  end
end
