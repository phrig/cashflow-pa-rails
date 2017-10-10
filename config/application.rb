require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

Dotenv::Railtie.load

HOSTNAME = ENV['HOSTNAME']

module CashFlowPa
  class Application < Rails::Application
    config.api_only = true
  end
end
