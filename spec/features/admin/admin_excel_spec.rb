RSpec.describe 'admin_excel', driver: :selenium_chrome, js: true do
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
      visit admin_excel_path
      expect(page).to have_content('Excel')
    end
  end

  context :excel_download do
    it :success do
      visit admin_excel_path
      find('#download_excel').click
    end
  end
end
