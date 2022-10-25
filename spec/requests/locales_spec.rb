require 'rails_helper'

RSpec.describe LocalesController, type: :controller do
  it 'тестируем редирект' do
    post :toggle
    expect(response).to have_http_status(:redirect)
  end

  it 'локаль по дефолту' do
    expect(I18n.locale).to eq(:ru)
  end
end
