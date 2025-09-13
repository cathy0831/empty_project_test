# spec/rails_helper.rb
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"
require "factory_bot_rails"
require "shoulda/matchers"

# 載入 support 目錄下所有檔案
Rails.root.glob("spec/support/**/*.rb").each { |f| require f }

# 確保 DB schema 是最新
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # FactoryBot 簡化語法
  config.include FactoryBot::Syntax::Methods

  # 支援使用自定義 helper module
  config.include PermissionHelper
  config.include LoginHelper, type: :request

  # 允許使用 shoulda-matchers
  Shoulda::Matchers.configure do |sm_config|
    sm_config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  # RSpec 設定
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # 清理測試 DB
  config.use_transactional_fixtures = true

  # 亂數執行測試順序
  # config.order = :random
  # Kernel.srand config.seed
end
