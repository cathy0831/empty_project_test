require "active_support/core_ext/integer/time"

Rails.application.configure do
  # 正式環境關閉熱重載，提高穩定性與效能
  config.enable_reloading = false

  # 開啟類別快取，提高請求速度
  config.cache_classes = true

  # 啟動 eager load，預載所有程式碼以支援多線程與複寫優化
  config.eager_load = true

  # 不顯示詳細錯誤頁面，避免洩漏敏感資訊
  config.consider_all_requests_local = false

  # 啟用 controller 快取功能，提升性能
  config.action_controller.perform_caching = true

  # 是否由 Rails 伺服靜態資源，生產環境通常由 NGINX/Apache 代勞
  # ENV 變數可控制，這裡預設為 true
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present? || true

  # 不允許資產漏網時重新編譯，提升效能與穩定性
  config.assets.compile = false

  # 可使用 SASS 等工具壓縮 CSS
  # config.assets.css_compressor = :sass

  # 設定資產伺服器（CDN）位址，依需求啟用
  # config.asset_host = "https://cdn.example.com"

  # 可用於 NGINX / Apache 傳送靜態檔案的設定
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # NGINX

  # 上傳檔案服務，正式環境可改成雲端（如 S3），這裡仍使用 local
  config.active_storage.service = :local

  # 強制所有請求使用 SSL，提升安全性
  # config.force_ssl = true

  # 日誌輸出設定
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    # 直接輸出到 STDOUT（適合容器或 cloud env）
    logger = ActiveSupport::Logger.new($stdout)
    logger.formatter = Logger::Formatter.new
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  else
    # 輸出至每日檔案
    config.logger = ActiveSupport::Logger.new(config.paths["log"].first, "daily")
  end

  # 日誌等級，預設 info 可用 ENV 覆寫
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info").to_sym

  # 日誌中標註 request_id，方便追蹤請求
  config.log_tags = [:request_id]

  # 使用預設格式化器，保留 PID 與時間戳
  config.log_formatter = Logger::Formatter.new

  # 快取儲存（可根據需求啟用 mem_cache_store）
  # config.cache_store = :mem_cache_store

  # Active Job 背景工作配置範例（可依需求調整）
  # config.active_job.queue_adapter = :resque
  # config.active_job.queue_name_prefix = "yourapp_production"

  # mailer 不快取
  config.action_mailer.perform_caching = false

  # 設定郵件寄送方式為 SMTP，載入 config/email.yml 內容
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = config_for(:email).symbolize_keys

  # 郵件寄送失敗不拋錯（依需求可改）
  # config.action_mailer.raise_delivery_errors = false

  # I18n 翻譯找不到時使用 fallback 語言
  config.i18n.fallbacks = true

  # 不輸出過時警告訊息，避免噪音
  config.active_support.report_deprecations = false

  # 遷移後不備份 schema，避免產生不必要檔案
  config.active_record.dump_schema_after_migration = false

  # DNS rebinding 防護設定，視需求啟用
  # config.hosts = [ "example.com", /.*\.example\.com/ ]
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
