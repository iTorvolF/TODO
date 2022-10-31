require 'rails_helper'

RSpec.describe Admin::EventsController, driver: :selenium_chrome, js: true do
  let(:user_admin) { create :admin }
  
  before do
    visit new_user_session_path
    fill_in 'user_email', with: user_admin.email
    fill_in 'user_password', with: user_admin.password
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
    let(:user) { create :user}
    let(:event) { create :event, name: 'test.event', user:user }

    it 'успешный переход' do
      sleep 1
      visit admin_event_path(event.id)
      expect(page).to have_current_path admin_event_path(event.id), ignore_query: true
      expect(page).to have_content('test.event')
    end
  end

  context :new do
    let(:user) { create :user, name: 'new_user' }
    let(:event_attr) { attributes_for(:event, user: user) }
    it 'успешно создает новое событие' do
      sleep 1
      user
      visit new_admin_event_path
      option = user.name
      find('#event_user_id').find('option', text: /#{option}/i).select_option
      fill_in 'event_name', with: event_attr[:name]
      fill_in 'event_content', with: event_attr[:content]
      click_button 'commit'
      expect(page).to have_content(event_attr[:name])
      expect(current_path).to match /\/admin\/events\/\d+/
    end
  end

  context :edit do
    let(:user) { create :user }
    let(:event) { create :event, user: user }

    it 'успешно отрабатывает' do
      sleep 1
      visit edit_admin_event_path(event.id)
      fill_in 'event_name', with: 'newtestname'
      fill_in 'event_content', with: 'newtestcontent'
      click_button 'commit'

      expect(page).to have_content('newtestname')
      expect(page).to have_content('newtestcontent')
      expect(page).to have_current_path admin_event_path(event.id), ignore_query: true
    end    
  end

  context :delete do
    it 'успешно отрабатывает' do
      sleep 1
      delete_event = create(:event, name: 'test_delete_event')
      visit admin_events_path
      page.accept_confirm do
        find(".delete_link[href='/admin/events/#{delete_event.id}']").click
      end

      expect(page).not_to have_content('test_delete_event')
      expect { delete_event.reload }.to raise_error ActiveRecord::RecordNotFound
    end    
  end 
end  