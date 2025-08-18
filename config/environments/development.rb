require "active_support/core_ext/integer/time"

Rails.application.configure do
  # 在開發時開啟熱重載，不用重啟 server 即可看到程式碼改動結果
  config.enable_reloading = true

  # 不快取類別，程式碼每次請求都重新載入，方便開發測試
  config.cache_classes = false

  # 不會在啟動時預先載入全部程式碼，縮短啟動時間
  config.eager_load = false

  # 顯示完整錯誤頁面，方便 debug
  config.consider_all_requests_local = true

  # 啟用 server timing，可用於分析請求時間
  config.server_timing = true

  # 快取設定：透過檔案存在與否控制是否開啟快取
  if Rails.root.join("tmp/caching-dev.txt").exist?
    # 開啟快取
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    # 使用記憶體快取
    config.cache_store = :memory_store

    # 設定 public 文件快取標頭
    config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{2.days.to_i}" }
  else
    # 關閉快取
    config.action_controller.perform_caching = false

    # 使用 null_store，實質不快取
    config.cache_store = :null_store
  end

  # 上傳檔案儲存服務，開發環境用本地硬碟
  config.active_storage.service = :local

  # 開發環境 mailer 發送失敗不會阻斷程式
  config.action_mailer.raise_delivery_errors = false

  # mailer 不使用快取
  config.action_mailer.perform_caching = false

  # 記錄過時（deprecation）警告到日誌
  config.active_support.deprecation = :log

  # 禁止過時警告引發例外
  config.active_support.disallowed_deprecation = :raise

  # 不忽略任何過時警告訊息
  config.active_support.disallowed_deprecation_warnings = []

  # 有未遷移時，瀏覽器頁面會顯示錯誤提示
  config.active_record.migration_error = :page_load

  # 在查詢日誌中標示出觸發 SQL 的程式碼
  config.active_record.verbose_query_logs = true

  # 背景工作排程日誌顯示更詳細的入隊訊息
  config.active_job.verbose_enqueue_logs = true

  # 避免輸出資源檔案請求造成日誌雜訊
  config.assets.quiet = true

  # 當 before_action 指定不存在的 action 時，拋出錯誤
  config.action_controller.raise_on_missing_callback_actions = true

  # 可選：遺漏翻譯時拋出錯誤（預設關閉）
  # config.i18n.raise_on_missing_translations = true

  # 可選：在渲染的 view 中標記檔案名稱，方便 debug
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Action Cable 開發環境允許跨域請求
  # config.action_cable.disable_request_forgery_protection = true
end
