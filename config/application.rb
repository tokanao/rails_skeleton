require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    config.active_record.default_timezone = :local
    config.time_zone = "Tokyo"
    config.beginning_of_week = :sunday

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.jbuilder false
      g.helper false
      g.gbuilder false
      g.test_framework :rspec, view_specs: false, helper_specs: false, fixture: true
      g.fixture_replacement :factory_girl, dir: "spec/support/factories"

      g.template_engine :slim
    end

    # 全ての helper が view から読めるのを禁止
    config.action_controller.include_all_helpers = false

    # NOTE: Responsed to too late better_errors
    #   ref. http://y-yagi.tumblr.com/post/144335019925/rails-50-puma-3%E7%B3%BB%E3%81%AE%E7%92%B0%E5%A2%83%E3%81%A7better-errors
    def inspect
      "#<#{self.class}>"
    end
  end
end
