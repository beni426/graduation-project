require_relative 'boot'

require 'rails/all'
Bundler.require(*Rails.groups(:assets => %w(development test)))


module Kiraibar
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.assets.compile = true
    config.serve_static_assets= true
    config.i18n.available_locales = %i(ja en)
    config.i18n.enforce_available_locales = true
    config.active_record.default_timezone = :local
    config.active_model.il8_customize_full_message = true
    config.i18n.load_path += Dir[Rails.root.join('config','locales','**','*.yml').to_s]
    config.i18n.default_locale = :ja
    config.load_defaults 6.0
    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
      model_specs: true,
      helper_specs: false,
      routing_specs: false
      
    end
  end
end
