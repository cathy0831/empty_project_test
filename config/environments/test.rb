require "active_support/core_ext/integer/time"

Rails.application.configure do
  # 測試環境會加快測試速度，不需重載程式碼
  config.cache_classes = true

  # 不需要 eager load，節省啟動時間
  config.eager_load = false

  # 不顯示錯誤頁面，測試用報錯即可
  config.consider_all_requests_local = true

  # 禁用快取，避免測試結果互相影響
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # 不需要靜態檔案伺服器（一般不在測試時用）
  config.public_file_server.enabled = false

  # 測試檔案儲存，通常使用測試專用的本地目錄
  config.active_storage.service = :test

  # 測試郵件不送出，只累積在 ActionMailer::Base.deliveries 陣列中
  config.action_mailer.delivery_method = :test
  config.action_mailer.perform_caching = false

  # 明確拋出錯誤，避免測試假過
  config.action_mailer.raise_delivery_errors = true

  # 只在測試日誌輸出必要資訊，減少噪音
  config.log_level = :warn

  # 測試時不產生過時警告
  config.active_support.report_deprecations = false

  # 遷移後不備份 schema，避免測試檔案雜亂
  config.active_record.dump_schema_after_migration = false

  # 預設以檔案形式記錄日誌（可改成 nil 避免檔案）
  config.logger = Logger.new(nil)

  # 測試時背景工作同步執行
  config.active_job.queue_adapter = :inline

  # 測試環境特定設定，視需求調整
  # config.i18n.fallbacks = true
end
