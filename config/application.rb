# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OutdoorsyApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Log to STDOUT. You could then collect logs using journald, syslog or forward them somewhere else.
    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.autoload_paths += %W[#{config.root}/app/helpers]
  end
end
