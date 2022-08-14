namespace :storage_size do
  include ActionView::Helpers::NumberHelper
  desc 'Вычисляем размер всех загруженных в ActiveStorage файлов'
  task files_size: :environment do
    puts "Размер всех файлов: #{number_to_human_size(ActiveStorage::Blob.sum(:byte_size))}"
  end
end
