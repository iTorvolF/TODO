require 'rails_helper'

RSpec.describe Admin::EventsController, driver: :selenium_chrome, js: true do
  let(:user) { create :admin }
  
  before do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'commit'
  end

  context :index do
    it :success do
      sleep 1
      visit admin_events_path
      expect(page).to have_content('События')
    end

    it 'успешно отражает новое событие' do
      @event = create(:event, user: create(:user))
      visit admin_events_path
      expect(page).to have_content(@event.user.name)
    end
  end

  context :show do
    let(:default_event) { create :event, name: 'test.event' }

    it 'успешный переход' do
      sleep 1
      visit admin_event_path(default_event)
      expect(page).to have_current_path admin_event_path(default_event), ignore_query: true
      expect(page).to have_content('test.event')
    end
  end  
end  