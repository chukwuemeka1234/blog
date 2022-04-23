require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    config.api_only = true
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.debug_exception_response_format = :default
    config.session_store :cookie_store, key: '_interslice_session'

    config.middleware.use ActionDispatch::Flash

    config.middleware.use config.session_store, config.session_options
  end
end
