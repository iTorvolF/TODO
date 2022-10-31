RSpec.describe Admin::UsersController, driver: :selenium_chrome, js: true do
  let(:user) { create :admin }
  
  before do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'commit'
  end

  context :index do
    it 'успешный переход' do
      sleep 1
      visit admin_import_eksport_polzovateley_path
      expect(page).to have_content('Экспорт')
      expect(page).to have_content('Импорт')
    end
  end
end  