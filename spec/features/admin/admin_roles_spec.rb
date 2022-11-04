RSpec.describe 'Roles', driver: :selenium_chrome, js: true do
  let(:user) { create :admin }

  before do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'commit'
    sleep 1
  end

  context :index do
    it :success do
      visit admin_roles_path
      expect(page).to have_content('Roles')
    end
  end

  context :new do
    it 'успешно создается новая роль' do
      visit new_admin_role_path
      fill_in 'role_name', with: 'new_role_name'
      fill_in 'role_code', with: 'new_role_code'
      click_button 'commit'
    end
  end
end
