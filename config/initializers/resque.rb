require 'resque/server'

Resque.redis = Redis.new(Rails.application.config_for(:queue))