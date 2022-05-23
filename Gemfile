source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "sassc-rails", "~> 2.0.0"
gem "activeadmin"
gem "pundit"
gem "devise-i18n"
gem "devise"
gem "pg", "~> 1.1"
gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "letter_opener"
  gem "simplecov", require: false  
  gem "shoulda-matchers"  
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "ffaker"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "ffi"
  gem "slim-rails"
  gem "web-console"
  gem "kaminari"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
