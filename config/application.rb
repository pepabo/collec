require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Answer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.cache_store = :redis_store, "#{ENV['REDIS_URL']}/0/cache", { expires_in: 3.minutes }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set timezone to display datetime in JST
    # ref: http://qiita.com/sutoh/items/b7d23990abb9c5083daa
    config.time_zone = 'Tokyo'

    config.paths.add 'lib', eager_load: true
  end
end
