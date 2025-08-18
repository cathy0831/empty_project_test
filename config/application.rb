require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EmptyProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # 時區設定
    config.time_zone = "Taipei"
    config.active_record.default_timezone = :utc

    # 語系設定
    config.i18n.default_locale = :"zh-TW"
    config.i18n.available_locales = [:"zh-TW"]
    config.i18n.load_path += Rails.root.glob("config/locales/**/*.{rb,yml}")

    # 自動載入 lib 目錄
    # 忽略不含 .rb 的 lib 子資料夾，避免不必要的 reload
    config.autoload_lib(ignore: %w[assets tasks])

    # generators 預設不產生樣式、腳本、helper 檔案
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.system_tests nil
    end

    # audited gem 允許 YAML 序列化時的安全類別
    config.active_record.yaml_column_permitted_classes = [BigDecimal, Date, Enumerize::Value]
  end
end
