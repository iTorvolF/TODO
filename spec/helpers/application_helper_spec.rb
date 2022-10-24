require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it :current_date do
    expect(helper.current_date).to eq Date.current.to_s
  end

  context :language_link_name do
    it 'локаль по умолчанию' do
      expect(helper.language_link_name).to eq 'EN'
    end

    it 'локаль установлена в ru' do
      session[:locale] = 'ru'
      expect(helper.language_link_name).to eq 'EN'
    end

    it 'локаль установлена в en' do
      session[:locale] = 'en'
      expect(helper.language_link_name).to eq 'RU'
    end

    it 'локаль установлена в pt' do
      session[:locale] = 'pt'
      expect(helper.language_link_name).to eq 'EN'
    end
  end
end
