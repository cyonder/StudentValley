require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module StudentValley
  class Application < Rails::Application

    config.active_record.raise_in_transactional_callbacks = true

    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.{rb,yml}"]

    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local
  end
end
