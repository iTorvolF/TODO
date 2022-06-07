# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'action_mailer/railtie'
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module Newtodo
  class Application < Rails::Application
    config.load_defaults 7.0

    config.i18n.available_locales = [:en, :ru]
    config.i18n.default_locale = :ru
    config.time_zone = 'Moscow'
    config.paths.add Rails.root.join('app', 'api', 'helpers').to_s, eager_load: true
    config.generators.system_tests = nil
  end
end
