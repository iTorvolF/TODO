# frozen_string_literal: true

# gem install ffaker

namespace :create do
  desc 'Заполняем таблицы пользователей, ролей, дел и подпунктов тестовыми данными'
  task filling: :environment do
    User.create name: FFaker::Name.name, email: FFaker::Internet.email
    Event.create name: FFaker::Lorem.word, content: FFaker::Lorem.sentence, finished_at: FFaker::Time.date
    Role.create name: FFaker::Lorem.word, code: FFaker::Lorem.word
    Item.create name: FFaker::Lorem.word, finished_at: FFaker::Time.date
  end
end
