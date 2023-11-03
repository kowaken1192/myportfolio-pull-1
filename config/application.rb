require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module LikeApp
  class Application < Rails::Application
    config.load_defaults 6.1

    # 英語化の設定
    config.i18n.default_locale = :ja

    # タイムゾーンの変更（例：created_at カラムを取り出したときに日本時間に変換されるようになる）
    config.time_zone = 'Asia/Tokyo'

    # その他の設定
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
