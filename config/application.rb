require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # 日本語化の設定
    config.i18n.default_locale = :ja
    # タイムゾーンの変更（例）created_at カラムを取り出したときに日本時間に変換されるようになる）
    config.time_zone = 'Asia/Tokyo'

    # Configuration for the application, engines, and railties goes here.
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
