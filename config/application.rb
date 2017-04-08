require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Inquiry
  class Application < Rails::Application
    config.i18n.default_locale = 'zh-TW'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_view.sanitized_allowed_tags = %w[(h1 h2 h3 h4 b i p u a pre div span br ul ol li em strong strike img]
    config.autoload_paths += Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }
    config.autoload_paths += Dir[File.join(Rails.root, "lib", "inputs", "*.rb")].each {|l| require l }

  end
end
