source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 7.1.3"
gem "audited"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap-sass"
gem "blueprinter"
gem "enumerize"
gem "exception_notification"
gem "foreman"
gem "jbuilder", "~> 2.5"
gem "mysql2"
gem "pagy"
gem "puma", "~> 5.0"
gem "rails-i18n"
gem "i18n-js", "~> 3.9"
gem "sass-rails", "~> 5.0"
gem "service_actor"
gem "service_actor-rails"
gem "slack-notifier"
gem "turbo-rails"
gem "uglifier", ">= 1.3.0"
gem "whenever", require: false
gem "vite_rails"

group :development, :test do
  gem "annotate"
  gem "bullet"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-rails"
  gem "rails-controller-testing"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "simplecov"
end

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

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
