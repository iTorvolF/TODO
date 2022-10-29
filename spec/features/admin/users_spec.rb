require 'rails_helper'

RSpec.describe Admin::UsersController, driver: :selenium_chrome, js: true do
  let(:user) { create :admin }
  
  before do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'commit'
  end

  context 'индексная страница' do
    it 'успешный переход' do
      expect(page).to have_content('пользователей')
    end

    it 'успешно отражает нового пользователя' do
  	  create(:user, name: 'test.user')
  	  visit admin_users_path
  	  expect(page).to have_content('Test.User')
  	end
  end

  context :show do
    let(:default_user) { create :user, name: 'test.user' }

    it 'успешный переход' do
      sleep 1
      visit admin_user_path(default_user)
      expect(page).to have_current_path admin_user_path(default_user), ignore_query: true
      expect(page).to have_content('Test.User')
    end
  end  

  context :new do
    let(:role) { create :role, name: 'new_role' }
    let(:default_attr) { attributes_for :user, role: role }

    it :success do
      sleep 1
      role
      visit new_admin_user_path
      fill_in 'user_email', with: default_attr[:email]
      fill_in 'user_name', with: default_attr[:name]
      select default_attr[:role].name, from: 'user_role_id'
      fill_in 'user_password', with: default_attr[:password]
      fill_in 'user_password_confirmation', with: default_attr[:password]
      click_button 'button'

      expect(page).to have_current_path(%r{/admin/users/\d+})
      expect(page).to have_content(default_attr[:name].downcase.titleize)
      expect(page).to have_content(default_attr[:email])
    end
  end
end		