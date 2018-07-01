require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Revision
  class Application < Rails::Application
    
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1


    # Path to blog repository
    config.x.repo = "./../blog2"

    # Enable running in sub-dir for assets
    config.relative_url_root = ""

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    def self.read_config
      begin
        cfg = YAML.load_file("#{config.x.repo}/revision.yml")
      rescue
        cfg = Hash.new
      end
      
      if !cfg.has_key?("title")
        cfg["title"] = "My Blog"
      end

      if !cfg.has_key?("ignore")
        cfg["ignore"] = Array.new
      end

      cfg["ignore"].push("revision.yml")

      return cfg
    end
    
    config.assets.prefix = "#{config.relative_url_root}#{config.assets.prefix}"
    config.assets.paths << config.x.repo 
    config.x.settings = read_config()

  end

end
