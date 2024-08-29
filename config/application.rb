require_relative "boot"

require "rails/all"
require 'simple_calendar'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SbAdmin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_record.schema_format = :sql
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' # o el dominio específico que permitas
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'Caracas'
    config.action_cable.mount_path = '/cable'
    config.action_cable.allowed_request_origins = ['http://127.0.0.1:5173']
    config.action_cable.url = 'ws://localhost:3000/cable'

    config.view_component.preview_paths << "#{Rails.root}/spec/components/previews" if Rails.env.development?

    # Configuration for the application, engines, and railties goes here.
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << RailZs.root.join("extras")
  end
end
