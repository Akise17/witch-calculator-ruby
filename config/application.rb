require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module WitchCalculator
  class Application < Rails::Application
    config.load_defaults 7.0
    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths += %W[#{config.root}/app/services]
    config.assets.paths << Rails.root.join('node_modules', 'bootstrap', 'scss')
  end
end
