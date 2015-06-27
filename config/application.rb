require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Bundler group settings
bundler_settings = { 
  basic_debug:          %w(development test),
  quality_analysis:     %w(development test),
  performance_analysis: %w(development test),
  documentation:        %w(development test),
  heroku:               %w(production)
}
# Require general functions for all application environments, map other
# function groups to application environments as indicated in bundler_settings
if defined?(Bundler)
  Bundler.require(*Rails.groups(bundler_settings))
end

module PlacemarkStory
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
  end
end

config.serve_static_assets = true