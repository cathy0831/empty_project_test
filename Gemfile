source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.2"

gem "rails", "~> 7.1.5"

# 基礎
gem "activerecord-session_store"
gem "audited"
gem "bcrypt", "~> 3.1"
gem "blueprinter"
gem "bootsnap", ">= 1.18.3", require: false
gem "bootstrap", "~> 5.3"
gem "enumerize"
gem "exception_notification"
gem "foreman"
gem "i18n-js", "~> 3.9"
gem "jbuilder", "~> 2.11"
gem "mysql2", ">= 0.5.5"
gem "pagy"
gem "puma", "~> 6.4"
gem "rails-i18n", "~> 7.0"
gem "sassc-rails" # 取代舊 sass-rails
gem "service_actor"
gem "service_actor-rails"
gem "slack-notifier"
gem "turbo-rails"
gem "vite_rails"
gem "whenever", require: false

# 開發與測試
group :development, :test do
  gem "annotate"
  gem "bullet"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "ffaker"
  gem "pry-rails"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 6.0"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end

# 開發
group :development do
  gem "better_errors"
  gem "brakeman"
  gem "listen"
  gem "rails_best_practices"
  gem "reek"
  gem "rubocop", require: false
  gem "rubocop-erb", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "web-console"
end

# Windows 支援
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
