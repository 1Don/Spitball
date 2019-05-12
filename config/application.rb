require_relative 'boot'
require 'rails/all'
require "active_storage"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Spitball
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
   config.exception_handler = {

      dev: false,
      layouts: {
        500 => '_landing',
        400 => '_landing',
        404 => '_landing'
      }
  }
  config.assets.initialize_on_precompile = false
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
