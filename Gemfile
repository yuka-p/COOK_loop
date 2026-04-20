source "https://rubygems.org"

# --- 基本・フレームワーク ---
gem "rails", "~> 7.2.3"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false

# --- フロントエンド (Asset Pipeline / JavaScript / CSS) ---
gem "sprockets-rails"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"

# --- 認証・便利機能 ---
gem "devise"
gem "devise-i18n"
gem "acts_as_list"

# --- API連携（楽天レシピAPI用） ---
gem "faraday"
gem "dotenv-rails"

# --- Windows用 (環境に合わせて自動適用) ---
gem "tzinfo-data", platforms: %i[ windows jruby ]

# --- 開発環境・テスト環境 ---
group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", "~> 8.0", require: false
  gem "rubocop", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
  gem "letter_opener"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
