# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'active_storage/engine'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Newtodo
  class Application < Rails::Application
    config.load_defaults 7.0

    config.i18n.available_locales = %i[en ru]
    config.i18n.default_locale = :ru
    config.time_zone = 'Moscow'
    config.paths.add Rails.root.join('app/api/helpers').to_s, eager_load: true
    config.paths.add Rails.root.join('lib').to_s, eager_load: true
    config.generators.system_tests = nil
    config.active_job.queue_adapter = :resque
    config.active_storage.variant_processor = :vips
    # config.active_job.queue_adapter = :sidekiq

     config.generators do |g|
      g.org             :active_record
      g.template_engine :slim
      g.system_tests    nil
      g.test_framework  nil
      g.helper          false
      g.stylesheets     false
      g.javascript      false
      g.factory_bot     dir: 'spec/factories'
    end
  end
end
