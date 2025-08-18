require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Staging 環境通常關閉熱重載，效能與穩定性要求接近正式環境
  config.enable_reloading = false

  # 類別快取開啟，避免每次請求重新載入程式碼
  config.cache_classes = true

  # 啟用 eager load，提升多線程與記憶體複用效能
  config.eager_load = true

  # 不顯示詳細錯誤頁，避免暴露系統資訊
  config.consider_all_requests_local = false

  # 啟用快取提升性能
  config.action_controller.perform_caching = true

  # 靜態資源是否由 Rails 提供，預設開啟方便 staging 部署
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present? || true

  # 不允許資產漏網時重新編譯，維持穩定
  config.assets.compile = false

  # CSS 壓縮設定，可依需求啟用
  # config.assets.css_compressor = :sass

  # 資產伺服器 (CDN) 設定，依需求啟用
  # config.asset_host = "https://cdn.staging.example.com"

  # 靜態檔案送出設定，可依 Web Server 調整
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # NGINX

  # 上傳檔案服務，staging 一般使用 local，或可改成雲端服務測試
  config.active_storage.service = :local

  # 強制使用 SSL 提升安全，與正式環境一致
  # config.force_ssl = true

  # 日誌輸出設定，staging 環境可輸出到檔案，方便回溯
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new($stdout)
    logger.formatter = Logger::Formatter.new
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  else
    # 一天一份日誌輪替
    config.logger = ActiveSupport::Logger.new(config.paths["log"].first, "daily")
  end

  # 日誌等級，預設 info，可用環境變數覆寫
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "debug").to_sym

  # 日誌中加入 request_id 方便追蹤
  config.log_tags = [:request_id]

  # 使用預設日誌格式器
  config.log_formatter = Logger::Formatter.new

  # 快取儲存設定，依需求開啟
  # config.cache_store = :mem_cache_store

  # Active Job 背景工作配置（依需求開啟）
  # config.active_job.queue_adapter = :sidekiq
  # config.active_job.queue_name_prefix = "yourapp_staging"

  # mailer 不快取
  config.action_mailer.perform_caching = false

  # SMTP 設定載入 staging 版本 config/email.yml
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = config_for(:email).symbolize_keys

  # 郵件寄送失敗不拋錯（視需求可改）
  # config.action_mailer.raise_delivery_errors = false

  # I18n fallback 設定
  config.i18n.fallbacks = true

  # 過時警告不輸出
  config.active_support.report_deprecations = false

  # 遷移後不備份 schema
  config.active_record.dump_schema_after_migration = false

  # DNS rebinding 防護，可視需求開啟
  # config.hosts = [ "staging.example.com", /.*\.staging\.example\.com/ ]
  # config.host_authorization = { exclude: ->(request) { request.path == "/health" } }
end
