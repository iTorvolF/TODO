# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'action_mailer/railtie'

Bundler.require(*Rails.groups)

module Newtodo
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.default_locale = :ru
    config.time_zone = 'Moscow'
  end
end
