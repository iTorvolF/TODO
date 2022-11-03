RSpec.describe Admin::UsersController, driver: :selenium_chrome, js: true do
  let(:user) { create :admin }
  
  before do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'commit'
    sleep 1
  end

  context :index do
    it 'успешный переход' do
      visit admin_import_eksport_polzovateley_path
      expect(page).to have_content('Экспорт')
      expect(page).to have_content('Импорт')
      expect(page).to have_css('#uploads_form_excel')
    end
  end

  context :download do
    it 'успех' do
      visit admin_import_eksport_polzovateley_path
      click_button 'button'
    end
  end

  context :upload do
    it 'успех' do
      visit admin_import_eksport_polzovateley_path
      attach_file :uploads_form_excel, "spec/fixtures/user.xlsx"
      click_button "Загрузить"
    end
  end
end  